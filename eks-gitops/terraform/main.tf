provider "aws" {
  region = var.region
  assume_role { role_arn = var.role_arn }
}

data "aws_caller_identity" "current" {}

module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = var.cluster_name
  cluster_version = "1.28"
  subnets         = var.subnets
  vpc_id          = var.vpc_id
  node_groups = {
    default = {
      desired_capacity = 2
      max_capacity     = 3
      min_capacity     = 1
      instance_type    = "t3.medium"
    }
  }
}

data "aws_eks_cluster_auth" "default" {
  name = module.eks.cluster_id
}