variable "region" {}
variable "role_arn" {}
variable "cluster_name" {}
variable "subnets" { type = list(string) }
variable "vpc_id" {}
variable "github_org" {}
variable "github_repo" {}
variable "environment" {}