terraform {
  required_providers {
    helm = {
      source  = "hashicorp/helm"
      version = "3.0.2" # or latest stable
    }
  }
}


resource "null_resource" "ibmcloud_oc_login" {
  provisioner "local-exec" {
    command = <<EOT
      ibmcloud login --apikey ${var.ibmcloud_api_key} -r us-east
      sleep 3
      ibmcloud oc cluster config --cluster ${var.cluster_id} --admin --output json >./newcluster.conf
    EOT
  }
}

# provider "helm" {
#   kubernetes {
#     config_path = "${path.module}/dheeraj.conf"
#   }
# }

provider "helm" {
  kubernetes = {
    config_path = "./newcluster.conf"
  }
}


resource "helm_release" "redis" {
  name       = "my-redis"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "redis"
  values = [<<EOF
volumePermissions:
  enabled: true
EOF
  ]
  depends_on = [null_resource.ibmcloud_oc_login]
}


resource "helm_release" "postgresql" {
  name       = "my-postgresql"
  repository = "https://charts.bitnami.com/bitnami"
  chart      = "postgresql"
  version    = "16.1.0"

  values = [<<EOF
volumePermissions:
  enabled: true
auth:
  username: siroin
  password: sirion123
  database: sirion-db
primary:
  persistence:
    enabled: true
    size: 8Gi
pgHbaConfiguration: |
  host all all 10.0.0.0/8 md5
EOF
  ]
  depends_on = [null_resource.ibmcloud_oc_login]
}

