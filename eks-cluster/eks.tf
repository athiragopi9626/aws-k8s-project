
# EKS Cluster (Compute Layer)
module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0" # Latest major version

  cluster_name    = "gitops-demo-cluster"
  cluster_version = "1.31"
  

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # Access Management (Best Practice: No more aws-auth ConfigMap)
  enable_cluster_creator_admin_permissions = true
  authentication_mode                      = "API_AND_CONFIG_MAP"

  # Cost Optimization: Managed Node Group with Spot Instances
  eks_managed_node_groups = {
    spot_group = {
      # Use Spot for ~70% savings
      capacity_type = "SPOT"
      
      # Instance diversity prevents provisioning failures
      instance_types = ["t3.medium", "t3a.medium", "t2.medium"]

      min_size     = 1
      max_size     = 3
      desired_size = 2 # Start with 2 nodes for high availability
      
      # Security Best Practice: IMDSv2
      metadata_options = {
        http_endpoint               = "enabled"
        http_tokens                 = "required"
        http_put_response_hop_limit = 2
      }
    }
  }
}

