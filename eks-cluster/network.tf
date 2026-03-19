# . VPC for EKS (Networking Layer)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "gitops-test-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["eu-west-1a", "eu-west-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  # Cost Optimization: Single NAT Gateway instead of one per AZ
  enable_nat_gateway = true
  single_nat_gateway = true
  enable_dns_hostnames = true  # CRITICAL for EKS nodes to join cluster
  enable_dns_support   = true  # Ensures internal AWS DNS works

  # Mandatory Tags for AWS Load Balancer Controller
  public_subnet_tags = {
    "kubernetes.io/role/elb" = "1"
  }
  private_subnet_tags = {
    "kubernetes.io/role/internal-elb" = "1"
  }
}
