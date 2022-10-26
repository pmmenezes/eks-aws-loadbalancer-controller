
provider "kubernetes" {
  host                   = var.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["eks", "get-token", "--cluster-name", var.eks_cluster.name]
    command     = "aws"
  }
    config_path = "~/.kube/config"
}

resource "kubernetes_service_account" "aws_alb_controller" {
  metadata  {
      name = "aws-load-balancer-controller"
      namespace = "kube-system"
      annotations = {
        "eks.amazonaws.com/role-arn" = var.aws_iam_role_lb_controller.arn
      }
      labels = {
       "app.kubernetes.io/component" = "controller"
        "app.kubernetes.io/name" = "aws-load-balancer-controller"
      }
  }
}

provider "helm" {
  kubernetes {
    host                   = var.eks_cluster.endpoint
  cluster_ca_certificate = base64decode(var.eks_cluster.certificate_authority[0].data)
  exec {
    api_version = "client.authentication.k8s.io/v1"
    args        = ["eks", "get-token", "--cluster-name", var.eks_cluster.name]
    command     = "aws"
  }
    config_path = "~/.kube/config"
  }
}


resource "helm_release" "aws_alb_controller" {
  name = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart = "aws-load-balancer-controller"
  #version = "1.4.2"
  namespace = "kube-system"
  set {
    name = "clusterName"
    value = var.eks_cluster.name
  }
  set {
    name = "serviceAccount.create"
    value = "false"
  }
  set {
    name = "serviceAccount.name"
    value = kubernetes_service_account.aws_alb_controller.metadata[0].name 
  }
  set {
    name = "region"
    value = var.aws_region
  }
  set {
    name = "vpcId"
    value = var.cluster_vpc.id
  }

}

