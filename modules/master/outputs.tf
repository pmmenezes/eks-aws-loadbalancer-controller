output "eks_cluster" {
  value = aws_eks_cluster.eks_cluster
}

output "eks_cluster_name" {
  value = aws_eks_cluster.eks_cluster.name
}

output "aws_security_group" {
    value = aws_security_group.cluster_master_sg
  
}

output "aws_cluster_security_group_id" {
  value = aws_eks_cluster.eks_cluster.vpc_config[0].cluster_security_group_id
}

output "aws_identity_oidc" {
  value = aws_eks_cluster.eks_cluster.identity[0].oidc[0].issuer
}


output "aws_iam_role_lb_controller" {
  value = aws_iam_role.lb_controller
}

output "kubeconfig_ca_cert" {
  value = aws_eks_cluster.eks_cluster.certificate_authority[0].data
}