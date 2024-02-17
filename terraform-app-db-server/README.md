# Devops-exercise

Create a two tier architecture with the following AWS resources
- EC2
- RDS
- Route53

This exercise contains .tfvars file to deploy resources on 2 regions ap-northeast-1 and us-east-1. Respective AMI images based on regions is used for deployment

## Steps to reproduce

**Initialize terraform**

`terraform init`

**Run plan**

Region: ap-northeast-1
`terraform plan -var-file=config/ap-northeast-1.tfvars`

Region: us-east-1
`terraform plan -var-file=config/us-east-1.tfvars`

**Create the infrastructure**

Region: ap-northeast-1
`terraform apply -var-file=config/ap-northeast-1.tfvars`

Region: us-east-1
`terraform apply -var-file=config/us-east-1.tfvars`