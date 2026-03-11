# Purpose: Optional node autoscaler for dynamic scaling
resource "aws_iam_role" "karpenter" {
  name = "karpenter-controller"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{ Effect = "Allow", Principal = { Service = "karpenter.k8s.aws" }, Action = "sts:AssumeRole" }]
  })
}
# Helm install handled via CD workflow