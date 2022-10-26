resource "aws_eks_node_group" "cluster" {
  cluster_name = var.eks_cluster.name
  node_group_name = format("%s-node-group", var.cluster_name)
  node_role_arn = aws_iam_role.eks_nodes_roles.arn
  subnet_ids = [ var.private_subnet_1a.id, var.private_subnet_1c.id ]
  # instance_types =  var.nodes_instances_sizes

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired")
    max_size = lookup(var.auto_scale_options, "max")
    min_size = lookup(var.auto_scale_options, "min")
  }

  launch_template {
   name = aws_launch_template.k8s_launch_template.name
   version = aws_launch_template.k8s_launch_template.latest_version
  }
    tags = {
      "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    }
}



resource "aws_launch_template" "k8s_launch_template" {
  name = format("%s-launch-tpl", var.cluster_name)

  vpc_security_group_ids  =  [ var.eks_cluster_sg.id, var.eks_cluster_master ]
  block_device_mappings {
    device_name = "/dev/xvda"

    ebs {
      volume_size = 20
      volume_type = "gp3"
    }
  }

 # image_id = format("%s-ami", var.cluster_name)
  instance_type = tostring(var.nodes_instances_sizes[0])
#  user_data = base64encode(<<-EOF
#MIME-Version: 1.0
#Content-Type: multipart/mixed; boundary="==MYBOUNDARY=="
#--==MYBOUNDARY==
#Content-Type: text/x-shellscript; charset="us-ascii"
##!/bin/bash
#/etc/eks/bootstrap.sh your-eks-cluster
#--==MYBOUNDARY==--\
#  EOF
#  )

  tag_specifications {
    resource_type = "instance"

    tags = {
      Name = "EKS-MANAGED-NODE"
    }
  }
}