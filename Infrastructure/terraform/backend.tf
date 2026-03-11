terraform {
  required_version = ">= 1.10.0" # Required for native S3 locking

  backend "s3" {
    bucket       = "my-ai-bucket-project-backend"
    key          = "eks/ai-lab/terraform.tfstate"
    region       = "eu-west-1"
    
    #  No DynamoDB needed!
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
