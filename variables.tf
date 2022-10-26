variable "cluster_name" {
  description = "Nome do cluster ou projeto"
  type = string
#  default = "name_cluster"
}
variable "aws_region" {
  description = "Região onde será provisionado o cluster. Exemplo us-east-1 (Norte da Virgínia)"
  default = "us-east-1"
}

variable "vpc_cidr" {
  description = "Range deve ser privado com CIDR /16"
  default = "10.190.0.0/16"
}
variable "k8s_version" {
  description = "Versão do Kubernetes"
  type = string
  default = "1.22"
}
#
variable "nodes_instances_sizes" {
  description = "Tipo de EC2 que irá compor o nodes Workers"
  type = list
  default = ["t3.medium"]
}
variable "auto_scale_options" {
  description = "Valores para a scale up e scale down do cluster"
  type = map 
  default = {
      min = 2
      max = 3
      desired = 2
  }
}

variable "auto_scale_cpu" {
  default = {
    scale_up_threshold = 80
    scale_up_period = 120
    scale_up_evaluation = 2
    scale_up_cooldown = 300
    scale_up_add = 1

    scale_down_threshold = 40
    scale_down_period = 120
    scale_down_evaluation = 2
    scale_down_cooldown = 300
    scale_down_remove = -1
  }
  
}
