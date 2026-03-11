# Purpose: Create EKS cluster + managed node group
module "eks" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "portfolio-eks"
  cluster_version = "1.29"
  subnet_ids      = aws_subnet.public[*].id
  vpc_id          = aws_vpc.main.id
  enable_irsa     = true

  eks_managed_node_groups = {
    default = {
      desired_size = 1
      max_size     = 2
      min_size     = 1
      instance_types = ["t3.small"] # Budget-friendly
    }
  }

  tags = {
    Environment = "dev"
    Project     = "EKS-Portfolio"
  }
}

data "aws_eks_cluster" "eks" { name = module.eks.cluster_id }
data "aws_eks_cluster_auth" "eks" { name = module.eks.cluster_id }