terraform {
  required_version = ">= 1.10.0" # Required for native S3 locking

  backend "s3" {
    bucket       = "my-unique-ai-eks-state-bucket"
    key          = "eks/ai-lab/terraform.tfstate"
    region       = "eu-west-1"
    
    # THE MODERN WAY: No DynamoDB needed!
    use_lockfile = true 
    encrypt      = true
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}
