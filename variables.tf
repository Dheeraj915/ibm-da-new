variable "region" {
  type        = string
  description = "Region where VPC will be created. To find your VPC region, use `ibmcloud is regions` command to find available regions."
  default     = "us-south"
  
}

variable "ibmcloud_api_key" {
  type        = string
  description = "The IBM Cloud platform API key needed to deploy IAM enabled resources."

}

variable "prefix" {
  type        = string
  description = "A unique identifier for resources that is prepended to resources that are provisioned. Must begin with a lowercase letter and end with a lowercase letter or number. Must be 13 or fewer characters."
  default     = "lz-roks-qs"
  
}

variable "resource_tags" {
  type        = list(string)
  description = "Optional list of tags to be added to created resources"
  default     = []
}

variable "kube_version" {
  type        = string
  description = "Kubernetes version to use for cluster. To get available versions, use the IBM Cloud CLI command `ibmcloud ks versions`. Also supports passing the string 'default' (current IKS default recommended version)."
  default     = "default"
  
}

variable "flavor" {
  type        = string
  description = "Machine type for cluster. Use the IBM Cloud CLI command `ibmcloud ks flavors` to find valid machine types"
  default     = "bx2.4x16"
  
}

variable "entitlement" {
  type        = string
  description = "Reduces the cost of additional OCP in OpenShift clusters. If you do not have an entitlement, leave as null. Use Cloud Pak with OCP License entitlement to create the OpenShift cluster. Specify `cloud_pak` only if you use the cluster with a Cloud Pak that has an OpenShift entitlement. The value is set only when the cluster is created."
  default     = null
}

variable "cluster_names" {
  type        = string
  description = "name"
}

