# drf-tailapp-deploy/tf

This directory contains the infrastructure required for this deployment.

It is controlled with Terraform.

---

<!-- BEGIN_TF_DOCS -->

### Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.14.9 |

### Providers

| Name | Version |
|------|---------|
| aws | 4.1.0 |

### Resources

| Name | Type |
|------|------|
| [aws_db_instance.appdb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance) | resource |
| [aws_instance.apphost1](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/instance) | resource |
| [aws_lb.apphost-elb](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.lb_listener_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.apphost-group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_lb_target_group_attachment.instances](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.apphost-sg](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.rds](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |

### Inputs

| Name | Description | Default | Required |
|------|-------------|---------|:--------:|
| aws\_region | AWS resource region | `"eu-west-2"` | no |
| db\_name | RDS DB name | n/a | yes |
| db\_password | RDS password | n/a | yes |
| db\_username | RDS username | n/a | yes |
| vpc\_id | n/a | n/a | yes |

<!-- END_TF_DOCS -->
