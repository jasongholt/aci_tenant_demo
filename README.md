# Cisco ACI with GIT Demo #

This demo has been created to highlight how easy it can be to create a three tier networking configuration
for an ephemeral Tenant inside the Cisco ACI Fabric. 


This demo has been built using the Cisco always on Simulator that is availiable on Cisco Devnet. 


## Prerequisites ##

#### Terraform #####
https://www.terraform.io/downloads.html
https://learn.hashicorp.com/terraform/getting-started/install.html

**Optional**
Terraform Cloud Account
https://app.terraform.io

#### Cisco #####

* A Cisco Devnet Account
  * Access to the Cisco Always on Simulator: <https://https://devnetsandbox.cisco.com/RM/Topology>
  
**Usage**
- Make a new local directory
- Clone the repo to your own computer
- Update the variables.tf file with the correct defaults
  

```
terraform init
terraform plan
terraform apply
```