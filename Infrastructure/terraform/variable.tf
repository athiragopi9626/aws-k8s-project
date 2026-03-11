# Purpose: Declare all Terraform inputs, including sensitive variables
# Pre-requisites: All secrets provided via GitHub Actions or tfvars
# Safe for public repo: No default sensitive values stored here

# General
variable "aws_region" {
  description = "AWS region to deploy the cluster"
  type        = string
  default     = "eu-west-1"
}

variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
  default     = "portfolio-eks"
}

# Node group
variable "node_instance_type" {
  description = "EC2 instance type for node group"
  type        = string
  default     = "t3.small"  # Budget-friendly
}

variable "node_min_capacity" {
  description = "Minimum nodes for default node group"
  type        = number
  default     = 1
}

variable "node_desired_capacity" {
  description = "Desired nodes for default node group"
  type        = number
  default     = 1
}

variable "node_max_capacity" {
  description = "Maximum nodes for default node group"
  type        = number
  default     = 2
}
