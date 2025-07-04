output "cluster_names" {
 value       = var.prefix
 description = "List of create cluster names"
}

output "cluster_id" {
 value       = module.deploy-arch-ibm-slz-ocp.workload_cluster_id
 description = "List of create cluster names"
}

output "ibmcloud_api_key" {
 value       = var.ibmcloud_api_key
 description = "List of ip cluster names"
}
output "region" {
 value       = var.region
 description = "Region Name"
}

############
# This is a sample output file. Customize this file to fit your use case.
############

#output "key_management_crn" {
#  value       = var.key_management_crn
#  description = "CRN for KMS instance"
#}

#output "management_cluster_ingress_hostname" {
#  value       = var.management_cluster_ingress_hostname
#  description = "The hostname assigned for the Management cluster ingress subdomain, if not then null."
#}

#output "key_management_name" {
#  value       = var.key_management_name
#  description = "Name of key management service"
#}

#output "workload_rg_name" {
#  value       = var.workload_rg_name
#  description = "Resource group name for the workload resource group used within landing zone."
#}

#output "workload_rg_id" {
#  value       = var.workload_rg_id
#  description = "Resource group ID for the workload resource group used within landing zone."
#}

#output "workload_cluster_private_service_endpoint_url" {
#  value       = var.workload_cluster_private_service_endpoint_url
#  description = "The private service endpoint URL of the Workload cluster, if not then null."
#}

#output "prefix" {
#  value       = var.prefix
#  description = "The prefix that is associated with all resources"
#}

#output "management_rg_name" {
#  value       = var.management_rg_name
#  description = "Resource group name for the management resource group used within landing zone."
#}

#output "management_cluster_console_url" {
#  value       = var.management_cluster_console_url
#  description = "Management cluster console URL, if not then null."
#}

#output "transit_gateway_data" {
#  value       = var.transit_gateway_data
#  description = "Created transit gateway data"
#}

#output "resource_group_names" {
#  value       = var.resource_group_names
#  description = "List of resource groups names used within landing zone."
#}

#output "cluster_data" {
#  value       = var.cluster_data
#  description = "List of cluster data"
#}

#output "workload_cluster_ingress_hostname" {
#  value       = var.workload_cluster_ingress_hostname
#  description = "The hostname assigned for the Workload cluster ingress subdomain, if not then null."
#}

#output "vpc_data" {
#  value       = var.vpc_data
#  description = "List of VPC data"
#}

#output "management_cluster_public_service_endpoint_url" {
#  value       = var.management_cluster_public_service_endpoint_url
#  description = "The public service endpoint URL of the Management cluster, if not then null."
#}

#output "vpc_dns" {
#  value       = var.vpc_dns
#  description = "List of VPC DNS details for each of the VPCs."
#}

#output "key_map" {
#  value       = var.key_map
#  description = "Map of ids and keys for keys created"
#}

#output "key_management_guid" {
#  value       = var.key_management_guid
#  description = "GUID for KMS instance"
#}

#output "management_rg_id" {
#  value       = var.management_rg_id
#  description = "Resource group ID for the management resource group used within landing zone."
#}

#output "vpc_names" {
#  value       = var.vpc_names
#  description = "A list of the names of the VPC"
#}

#output "transit_gateway_name" {
#  value       = var.transit_gateway_name
#  description = "The name of the transit gateway"
#}

#output "workload_cluster_id" {
#  value       = var.workload_cluster_id
#  description = "The id of the workload cluster. If the cluster name does not exactly match the prefix-workload-cluster pattern it will be null."
#}

#output "key_rings" {
#  value       = var.key_rings
#  description = "Key rings created by module"
#}

#output "resource_group_data" {
#  value       = var.resource_group_data
#  description = "List of resource groups data used within landing zone."
#}

#output "vpc_resource_list" {
#  value       = var.vpc_resource_list
#  description = "List of VPC with VSI and Cluster deployed on the VPC."
#}

#output "workload_cluster_public_service_endpoint_url" {
#  value       = var.workload_cluster_public_service_endpoint_url
#  description = "The public service endpoint URL of the Workload cluster, if not then null."
#}

#output "management_cluster_private_service_endpoint_url" {
#  value       = var.management_cluster_private_service_endpoint_url
#  description = "The private service endpoint URL of the Management cluster, if not then null."
#}

#output "workload_cluster_console_url" {
#  value       = var.workload_cluster_console_url
#  description = "Workload cluster console URL, if not then null."
#}

#output "subnet_data" {
#  value       = var.subnet_data
#  description = "List of Subnet data created"
#}

# output "config" {
#  value       = var.config
#  description = "Output configuration as encoded JSON"
# }

#output "management_cluster_id" {
#  value       = var.management_cluster_id
#  description = "The id of the management cluster. If the cluster name does not exactly match the prefix-management-cluster pattern it will be null."
#}
