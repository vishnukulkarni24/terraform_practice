#################################################
# ENVIRONMENT
#################################################

variable "environment" {

  type = string
}

#################################################
# NETWORKING
#################################################

variable "vpc_cidr" {

  type = string
}

variable "availability_zones" {

  type = list(string)
}

#################################################
# SUBNETS
#################################################

variable "public_subnets" {

  type = list(string)
}

variable "private_subnets" {

  type = list(string)
}

#################################################
# TAGS
#################################################

variable "project_name" {

  type = string
}

variable "managed_by" {

  type = string

  default = "Terraform"
}
variable "admin_access_cidr" {

  description = "CIDR allowed for SSH access"

  type = string

  default = "0.0.0.0/0" # for the demo keep it For real production:Restrict it to: office IP VPN CIDR bastion subnet corporate network
}