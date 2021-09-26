# aws-terraform

Creates aws resources using terraform modules.

# Resources

- [VPC](#vpc/README.md)
  - [RouteTables](#asg/README.md)
  - [Subnets)](#asg/README.md)
  - [NATGateway](#asg/README.md)
  - [NACL](#asg/README.md)
  - [InternetGateway](#asg/README.md)
- [ASG](#asg/README.md)
- [ALB](#alb/README.md)
- [CloudWatch](#cloudwatch/README.md)
- [S#](#s3/README.md)
- [RDS](#rds/README.md)
- [DynamoDB](#dynamo/README.md)
- [SecurityGroups](#asg/README.md)
- [TargetGroups](#asg/README.md)
- [SQS](#asg/README.md)
- [SNS](#asg/README.md)
- [SES](#asg/README.md)
- [EC2Instances](#asg/README.md)

## Requirements

| Name      | Version    |
| --------- | ---------- |
| terraform | >= 0.12.26 |
| aws       | >= 2.48    |

## Providers

| Name | Version |
| ---- | ------- |
| aws  | >= 2.48 |

| Phase    | Equivalent `Terraform` Command |
| -------- | ------------------------------ |
| Planning | `terraform plan`               |
| Creation | `terraform apply`              |
| Update   | `terraform apply`              |
| Deletion | `terraform destroy`            |

**NOTE : `terraform.tfvars` file should be created and the above used variables should be initialized it the file.**

## Running locally.

**Clone the repository.**

```
# Initialize terraform.

make init

# Show resources to be created.

make plan

# Create resources.

make apply

```
