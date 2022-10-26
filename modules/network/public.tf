resource "aws_subnet" "public_subnet_1a" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 0 )
  map_public_ip_on_launch = true
  availability_zone       = format("%sa", var.aws_region)

  tags = {
    "Name" = format("%s-public-1a", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1

  }
}

resource "aws_subnet" "public_subnet_1c" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 1 )
  map_public_ip_on_launch = true
  availability_zone       = format("%sc", var.aws_region)

  tags = {
    "Name" = format("%s-public-1c", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/elb" = 1  
  }
}

resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_subnet_1a.id
  route_table_id = aws_route_table.igw_route_table.id

}