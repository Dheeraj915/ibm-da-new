terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2"
    }
    ibm = {
      source  = "ibm-cloud/ibm"   
      version = ">= 1.59.0, < 2.0.0"          
    }
  }
}
provider "ibm" {
  ibmcloud_api_key = var.ibmcloud_api_key
  region           = var.region
}

data "ibm_container_cluster_config" "sirion-roks-cluster" {
  cluster_name_id      = var.cluster_id
  admin                = true
}

provider "kubernetes" {
  host                   = data.ibm_container_cluster_config.sirion-roks-cluster.host
  token                  = data.ibm_container_cluster_config.sirion-roks-cluster.token
  cluster_ca_certificate = base64decode(data.ibm_container_cluster_config.sirion-roks-cluster.ca_certificate)
}

provider "helm" {
  kubernetes = {
  host                   = data.ibm_container_cluster_config.sirion-roks-cluster.host
  token                  = data.ibm_container_cluster_config.sirion-roks-cluster.token
  cluster_ca_certificate = base64decode(data.ibm_container_cluster_config.sirion-roks-cluster.ca_certificate)
  }
}


resource "helm_release" "redis" {
  name       = "sirion-redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  values = [<<EOF
image:
   tag: 7.0.0 
volumePermissions:
  enabled: true
EOF
  ]
  depends_on = [data.ibm_container_cluster_config.sirion-roks-cluster]
}

resource "helm_release" "postgresql" {
  name       = "sirion-postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "16.1.0"

  values = [<<EOF
image: 
   tag: 16.1.0
volumePermissions:
  enabled: true
auth:
  username: sirion
  password: sirion123
  database: sirion-db
primary:
  persistence:
    enabled: true
    size: 8Gi
pgHbaConfiguration: |
  host all all 10.0.0.0/8 md5
  host all all 172.0.0.0/8 md5
initdbScripts:
  init-letterbox.sql: |
    CREATE ROLE letterbox;
    ALTER ROLE letterbox WITH NOSUPERUSER INHERIT NOCREATEROLE CREATEDB LOGIN NOREPLICATION NOBYPASSRLS CONNECTION LIMIT 20 PASSWORD 'md5fde5f6d64c68520857e229236dcb7b0f';
    GRANT postgres TO letterbox WITH INHERIT TRUE GRANTED BY postgres;

    CREATE DATABASE letterbox;
    \connect letterbox

    GRANT CONNECT ON DATABASE letterbox TO letterbox;

    GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA public TO letterbox;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO letterbox;

    GRANT SELECT, UPDATE ON ALL SEQUENCES IN SCHEMA public TO letterbox;
    ALTER DEFAULT PRIVILEGES IN SCHEMA public GRANT SELECT, UPDATE ON SEQUENCES TO letterbox;

EOF
  ]
  depends_on = [data.ibm_container_cluster_config.sirion-roks-cluster]
}

##############################
# Headless Service
##############################

resource "kubernetes_service" "scylla" {
  metadata {
    name      = "scylla"
    namespace = "default"
    labels = {
      app = "scylla"
    }
  }

  spec {
    selector = {
      app = "scylla"
    }

    port {
      name        = "cql"
      port        = 9042
      target_port = 9042
    }

    cluster_ip = "None" # Required for StatefulSet
  }
  depends_on = [data.ibm_container_cluster_config.sirion-roks-cluster]
}

##############################
# StatefulSet (Single Node)
##############################

resource "kubernetes_stateful_set" "scylla" {
  metadata {
    name      = "scylla"
    namespace = "default"
  }

  spec {
    service_name = kubernetes_service.scylla.metadata[0].name
    replicas     = 1

    selector {
      match_labels = {
        app = "scylla"
      }
    }

    template {
      metadata {
        labels = {
          app = "scylla"
        }
      }

      spec {
        container {
          name  = "scylla"
          image = "scylladb/scylla:5.4"

          port {
            container_port = 9042
          }

          volume_mount {
            name       = "scylla-data"
            mount_path = "/var/lib/scylla"
          }

          resources {
            requests = {
              cpu    = "250m"
              memory = "512Mi"
            }
            limits = {
              cpu    = "500m"
              memory = "1Gi"
            }
          }
        }
      }
    }

    volume_claim_template {
      metadata {
        name = "scylla-data"
      }

      spec {
        access_modes = ["ReadWriteOnce"]
        storage_class_name = "ibmc-vpc-block-retain-general-purpose"

        resources {
          requests = {
            storage = "5Gi"
          }
        }
      }
    }
  }
  depends_on = [data.ibm_container_cluster_config.sirion-roks-cluster]
}




