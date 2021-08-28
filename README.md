# AWS EC2 - Docker - Terraform

## Pre - requisite 
   - AWS account
   - AWS Access Key ID.
   - AWS Secret Key ID.
   - IAM Role with access to create and connect to EC2
   - The script looks for AWS default VPC in the region you are trying to deploy     If there is no default VPC in the region you are trying to deploy, please       switch to the different region which has default resources (VPC, Subnets).
   - EC2 Private Key (PEM file) - Incase if you dont have one in the region you      would like to deploy. Please create a keypair (RSA, .pem), Add the PEM file     in the root of this folder.  

## Inputs 

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="aws_access_key"></a> [aws\_access\_key](#input\_aws\_access\_key) | AWS access key  | `string` | none | yes |
| <a name="aws_secret_key"></a> [aws\_secret\_key](#input\_aws\_secret\_key) | AWS secret key  | `string` | none | yes |
| <a name="key_name"></a> [key\_name](#input\_key\_name) | The name of thekey which you would like to use to ssh | `string` | none | yes |
| <a name="servers"></a> [servers](#input\_servers) | No of servers to be provisioned  | `number` | 1 | no |

## Outputs 

| Name | Description | Type |
|------|-------------|------|
| <a name="public_ips"></a> [public\_ips](#output\_public\_ips) | The public IP's of the servers provisioned  | `list(string)` |

## Instructions 

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 0.13.7 |

### Step-1 (Deployment)

- Please download the pem file which you would like to use and add it in the         folder.
- Fill the placeholders in `configs/lab.tfvars`.
- If you have the terraform (>= 0.13.7) version installed in your machine.
- To deploy in dev environment 
    ```bash
    terraform init
    terraform workspace new dev
    terraform plan --var-file=./configs/lab.tfvars -out dev.tfplan
    terraform apply "dev.tfplan"
    ```
- Incase If you don't have terraform installed in your machine 
    ```bash
    docker run -i -t -v $PWD:$PWD  -w $PWD hashicorp/terraform:0.13.7 init
    docker run -i -t -v $PWD:$PWD  -w $PWD hashicorp/terraform:0.13.7 workspace new dev
    docker run -i -t -v $PWD:$PWD  -w $PWD hashicorp/terraform:0.13.7 plan --var-file=./configs/lab.tfvars -out dev.tfplan
    docker run -i -t -v $PWD:$PWD  -w $PWD hashicorp/terraform:0.13.7 apply "dev.tfplan"
    ```
  
### Step-2 (Validate)

-  Once the servers are provisioned, you will see the list of public IP's. To        validate
    ```bash
    curl http://{IP}:4567
    ```
### Step-3 (Destroy)

- To cleanup the resources 
    
    ```bash
    terraform destroy --var-file=./configs/lab.tfvars
    ```

    ```bash
    docker run -i -t -v $PWD:$PWD  -w $PWD hashicorp/terraform:0.13.7 destroy --var-file=./configs/lab.tfvars
    ```


  



