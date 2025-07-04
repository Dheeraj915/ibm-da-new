# This is the original README that came from the deployable architecture. Please modify accordingly to fit your use case.

Depending on your level of customization, IBM Cloud might not support the deployable architecture. The components of the architecture supplied in the customization bundle are supported by IBM Cloud, but any customized code added to extend is not.

# Red Hat OpenShift Container Platform on VPC landing zone (QuickStart pattern)

![Architecture diagram for the QuickStart variation of ROKS on VPC landing zone](https://raw.githubusercontent.com/terraform-ibm-modules/terraform-ibm-landing-zone/main/reference-architectures/roks-quickstart.drawio.svg)

This pattern deploys the following infrastructure:

- Management VPC with one subnet, allow-all ACL and Security Group
- Workload VPC with two subnets, in two zones, allow-all ACL and Security Group
- Transit Gateway connecting VPCs
- One ROKS cluster in workload VPC with two worker nodes, public endpoint enabled
- Key Protect for cluster encryption keys
- Cloud Object Storage instance (required for cluster)

**Important:** This pattern helps you get started quickly, but is not highly available or validated for the IBM Cloud Framework for Financial Services.
