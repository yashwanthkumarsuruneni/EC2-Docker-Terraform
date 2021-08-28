##############################################################################
## VARIABLES
##############################################################################

variable "aws_access_key" {
  type = string
  description = "AWS access key"
}

variable "aws_secret_key" {
  type = string
  description = "AWS secret key"
}

variable "key_name" {
  type = string
  description = "The default key pair which you would like to use to shell into the instance"
}

variable "region" {
  default = "us-east-2"
}

variable "instance_type" {
  type = string
  description = "The default AWS instance type"
  default = "t2.medium"
}

variable "environment_name" {
  type = string
  description = "Environment name i.e, dev/qa/uat/prod"
}

variable "tags" {
  description = "A mapping of Tags for the resources "
  type = map(string)
  default = {}
}

variable "servers" {
  description = "Number of servers"
  type = number
  default = 1
} 

