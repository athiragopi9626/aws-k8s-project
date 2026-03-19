provider "flux" {
  kubernetes = {
    host                   = module.eks.cluster_endpoint
    cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.default.token
  }
  git = {
    url = "ssh://git@github.com/${var.github_org}/${var.github_repo}.git"
    ssh = {
      username    = "git"
      private_key = file("~/.ssh/id_rsa")
    }
  }
}

resource "flux_bootstrap_git" "this" {
  depends_on = [module.eks]
  path       = var.environment == "secondary" ? "apps/flux-app" : "apps/flux-app"
}