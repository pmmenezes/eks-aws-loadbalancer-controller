module "network" {
  source       = "./modules/network"
  cluster_name = var.cluster_name
  aws_region   = var.aws_region
  vpc_cidr = var.vpc_cidr
}

module "master" {
    source = "./modules/master"
    cluster_name = var.cluster_name
    aws_region = var.aws_region
    k8s_version = var.k8s_version
    cluster_vpc = module.network.cluster_vpc
    private_subnet_1a = module.network.private_subnet_1a
    private_subnet_1c = module.network.private_subnet_1c
}
#
module "nodes" {
  source ="./modules/nodes"
    cluster_name = var.cluster_name
    aws_region = var.aws_region
    k8s_version = var.k8s_version
    cluster_vpc = module.network.cluster_vpc
    private_subnet_1a = module.network.private_subnet_1a
    private_subnet_1c = module.network.private_subnet_1c

    eks_cluster  = module.master.eks_cluster
    eks_cluster_sg = module.master.aws_security_group
    eks_cluster_master = module.master.aws_cluster_security_group_id

    nodes_instances_sizes = var.nodes_instances_sizes
    auto_scale_options = var.auto_scale_options
    auto_scale_cpu = var.auto_scale_cpu

}
# 
 module "alb-controller-k8s" {
  source = "./modules/aws-alb-controller"
  eks_cluster  = module.master.eks_cluster
  aws_iam_role_lb_controller = module.master.aws_iam_role_lb_controller
  aws_region = var.aws_region
  cluster_vpc = module.network.cluster_vpc
  }
#
