module "deploy-arch-ibm-slz-ocp" {
  source      = "https://cm.globalcatalog.cloud.ibm.com/api/v1-beta/offering/source/archive//patterns/roks-quickstart?archive=tgz&flavor=quickstart&installType=fullstack&kind=terraform&name=deploy-arch-ibm-slz-ocp&version=v8.2.0"
  region      = var.region
  ibmcloud_api_key   = var.ibmcloud_api_key
  prefix = var.cluster_names
}
# ibm_container_vpc_cluster.cluster[0].id

module "sirion-base-infra" {
  source      = "./modules/"
  cluster_id   =  module.deploy-arch-ibm-slz-ocp.workload_cluster_id   ## We need to import this from the above mentioned module deploy-arch-ibm-slz-ocp
  ibmcloud_api_key  = var.ibmcloud_api_key
  region      = var.region
}