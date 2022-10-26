output "endpoint" {
  description = "Endpoint for your Kubernetes API server"
  value = module.master.eks_cluster.endpoint
}