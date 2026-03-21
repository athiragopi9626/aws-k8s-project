# 1. Single-AZ VPC (Free Tier Compatible)
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "${var.project_name}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.region}a"]       # Single AZ only
  private_subnets = ["10.0.1.0/24"]
  public_subnets  = ["10.0.101.0/24"]

  enable_nat_gateway   = true               # Free Tier compatible
  enable_dns_hostnames = true

  public_subnet_tags = {
    "kubernetes.io/role/elb" = 1
  }
}

# 2. EKS Cluster (Lightweight, Free Tier Safe)
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.project_name
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  enable_irsa = false                           # Optional for Free Tier
  cluster_endpoint_public_access = true

  # 3. Managed Node Groups (micro instances only)
  eks_managed_node_groups = {
    system = {
      instance_types = ["t3.micro"]            # Free Tier compatible
      min_size     = 1
      max_size     = 1
      desired_size = 1
    }
  }
}

# 4. Outputs
output "cluster_endpoint" {
  value = module.eks.cluster_endpoint
}

output "cluster_name" {
  value = module.eks.cluster_name
}



# # 1. Networking: Multi-AZ VPC
# module "vpc" {
#   source  = "terraform-aws-modules/vpc/aws"
#   version = "~> 5.0"

#   name = "${var.project_name}-vpc"
#   cidr = "10.0.0.0/16"

#   azs             = ["${var.region}a", "${var.region}b"]
#   private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
#   public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

#   enable_nat_gateway   = true
#   single_nat_gateway   = true # Saves cost for a lab environment
#   enable_dns_hostnames = true

#   public_subnet_tags = {
#     "kubernetes.io/role/elb" = 1
#   }
# }

# # 2. The EKS Cluster
# module "eks" {
#   source  = "terraform-aws-modules/eks/aws"
#   version = "~> 20.0"

#   cluster_name    = var.project_name
#   cluster_version = "1.31"

#   vpc_id                   = module.vpc.vpc_id
#   subnet_ids               = module.vpc.private_subnets
#   enable_irsa              = true # Essential for AI Pods to talk to AWS S3/EBS
#   cluster_endpoint_public_access = true

#   # 3. Managed Node Groups
#   eks_managed_node_groups = {
#     # System Nodes (Always On)
#     system = {
#       instance_types = ["t3.medium"]
#       min_size     = 1
#       max_size     = 2
#       desired_size = 1
#     }

#     # GPU Worker (The AI Engine)
#     gpu_ai = {
#       # G5 instances use NVIDIA A10G GPUs
#       instance_types = ["g5.xlarge"]
      
#       # Bottlerocket is the best-practice OS for EKS & AI
#       ami_type = "BOTTLEROCKET_x86_64_NVIDIA"
      
#       min_size     = 0
#       max_size     = 2
#       desired_size = 1 # Set to 0 via GH Actions when not in use to save money

#       labels = {
#         "hardware" = "nvidia-gpu"
#         "app"      = "ai-serving"
#       }

#       # Taints ensure standard apps don't accidentally use your expensive GPU
#       taints = [{
#         key    = "://nvidia.com"
#         value  = "true"
#         effect = "NO_SCHEDULE"
#       }]
#     }
#   }
# }

# # 4. Outputs for your GH Actions/CLI
# output "cluster_endpoint" {
#   value = module.eks.cluster_endpoint
# }

# output "cluster_name" {
#   value = module.eks.cluster_name
# }



