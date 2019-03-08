# Terraforming EC2 on AWS
###### Author: Chander M Singh 

This demonstrates how to create a multi-AZ Single-tier VPC on AWS. The architecture is based on AWS VPC Scenario  with 2 subnets: 

   - Public subnet for http servers 

VPC is provisioned using Terraform. 

Ec2 is created on public tier.

## Installation

  - Terraform v0.11.7 (or latest)
  - AWS keys set as environment variables using `aws_access_key` and `aws_secret_key`. Optionally, you may add these in terraform.tfvars

# Instructions 

- Add access key and secret keys in your AWS profile or pass variables

- Execute the following command to make sure you have properly configured AWS profile 

```
$ aws configure list
      Name                    Value             Type    Location
      ----                    -----             ----    --------
   profile                <not set>             None    None
access_key     ****************XYZZ shared-credentials-file
secret_key     ****************Puc0 shared-credentials-file
    region                ap-south-1      config-file    ~/.aws/config
```

Use Terraform to run and create the infrastructure: 

```sh
$ terraform init
$ terraform plan
$ terraform apply
```

To **teardown**, use Terraform destroy: 

```sh
$ terraform destroy -force
```

## Configuration 


| Variable             | Default                                    | Description                                        |
| :--------------------| :----------------------------------------- | :------------------------------------------------- |
| `region`             | `"ap-south-1"`                             | AWS region to create the VPC on                    |
| `vpc_name`           | `"timesinternet_vpc"`                      | Name of the VPC                                    | 
| `vpc_cidr`           | `"192.168.0.0/16"`                         | CIDR block for the VPC                             | 
| `availability_zones` | `["ap-south-1"]`                           | AZs to use, these should both be within the region |
| `ec2_key_pair_name`  |                                          | change this to your key pair                       |


### EC2 AMI Images 
Uses the latest Ubuntu LTS AMI dynamically as: 

## Files and Modules

The source is organized into separate files and modules for easier maintenance.

| File                           | Contents                                   |
| :----------------------------- | :----------------------------------------- |
| `main.tf`                      | AWS provider definition                    |
| `variables.tf`                 | Variables                                  |
| `vpc.tf`                       | VPC and subnets                            |
| `security-groups.tf`           | All security groups                        |
| 'terraform.tfvars`             | Terraform variables 
