############################################################################
# AWS Configuration                                                        #
############################################################################
variable "aws_access_key" {
  description = "aws access key"
}

variable "aws_secret_key" {
  description = "aws_secret key"
}

variable "region" {
  description = "asia pacific mumbai"
}

variable "public_key_path" {
  description = "Enter the path to the SSH Public Key to add to AWS ec2 instance."
  default     = "~/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  description = "Enter the path to the SSH Private Key to run provisioner."
  default     = "~/.ssh/id_rsa"
}

###########################  VPC Config ################################

variable "vpc_cidr" {
  description = "VPC cidr block"
}

variable "availability_zones" {
  description = "Availablity zones"
}

variable "disk_size" {
  default = 8
}

variable "count" {
  default = 1
}

variable "instance_type" {
  description = "AWS instance type to launch servers."
  default     = "t2.micro"
}

variable "key_name" {
  description = "AWS key name"
}
