# AWS EC2 - Docker - Terraform

## Pre - requisite 
   - AWS account
   - AWS Access Key ID.
   - AWS Secret Key ID.
   - IAM Role with access to create and connect to EC2
   - The script looks for AWS default VPC in the region you are trying to deploy     If there is no default VPC in the region you are trying to deploy, please       switch to the different region which has default resources (VPC, Subnets).
   - EC2 Private Key (PEM file) - Incase if you dont have one in the region you      would like to deploy. Please create a keypair (RSA, .pem), Add the PEM file     in the root of this folder.  

  
## Instructions 

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |

## Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS access key  | `string` | none | yes |
| <a name="aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS secret key  | `string` | none | yes |
| <a name="key_name"></a> [key_\name](#input\_key\_name) | The name of thekey which you would like to use to ssh | `string` | none | yes |
| <a name="servers"></a> [servers](#input\_servers) | AWS secret key  | `number` | 1 | no |


## Outputs 

| Name | Description | Type |
|------|-------------|------|
| <a name="public_ips"></a> [public\_ips](#output\_public\_ips) | The public IP's of the servers provisioned  | `string` |




