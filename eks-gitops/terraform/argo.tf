resource "helm_release" "argo_cd" {
  name       = "argo-cd"
  namespace  = "argocd"
  create_namespace = true
  repository = "https://argoproj.github.io/argo-helm"
  chart      = "argo-cd"
  version    = "5.50.0"

  set = [
    { name = "server.service.type", value = "LoadBalancer" }
  ]
}