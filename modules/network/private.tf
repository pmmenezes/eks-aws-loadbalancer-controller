resource "aws_subnet" "private_subnet_1a" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 2 )
  #"10.0.32.0/20"
  map_public_ip_on_launch = true
  availability_zone       = format("%sa", var.aws_region)

  tags = {
    "Name" = format("%s-private-1a", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1 

  }
}

resource "aws_subnet" "private_subnet_1c" {
  vpc_id                  = aws_vpc.cluster_vpc.id
  cidr_block              = cidrsubnet(var.vpc_cidr, 4, 3 )
  map_public_ip_on_launch = true
  availability_zone       = format("%sc", var.aws_region)

  tags = {
    "Name" = format("%s-private-1c", var.cluster_name),
    "kubernetes.io/cluster/${var.cluster_name}" = "shared"
    "kubernetes.io/role/internal-elb" = 1
  }
}

resource "aws_route_table_association" "private_1a" {
  subnet_id      = aws_subnet.private_subnet_1a.id
  route_table_id = aws_route_table.nat.id

}

resource "aws_route_table_association" "private_1c" {
  subnet_id      = aws_subnet.private_subnet_1c.id
  route_table_id = aws_route_table.nat.id

}