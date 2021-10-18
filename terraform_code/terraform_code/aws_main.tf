resource "aws_vpc" "vpc" {
  count                = terraform.workspace == "aws_prod" ? 1 : 0
  cidr_block           = var.cidr_vpc
  enable_dns_support   = true
  enable_dns_hostnames = true


  tags = {
    Environment = "${var.environment_tag}"
    Name        = "TerraformVpc"
  }
}

resource "aws_subnet" "subnet_public1_Lab1" {
  count                   = terraform.workspace == "aws_prod" ? 1 : 0
  vpc_id                  = aws_vpc.vpc[count.index].id
  cidr_block              = var.cidr_subnet1
  map_public_ip_on_launch = "true"
  availability_zone       = element(var.az, count.index)
  tags = {
    Environment = "${var.environment_tag}"
    Name        = element(var.subnet_names, count.index) #"TerraformPublicSubnetLab1"
  }

}

resource "aws_security_group" "TerraformSG" {
  count  = terraform.workspace == "aws_prod" ? 1 : 0
  name   = "TerraformSG"
  vpc_id = aws_vpc.vpc[count.index].id
  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Environment = "${var.environment_tag}"
    Name        = "TerraformSG"
  }

}
resource "aws_internet_gateway" "gw" {
  count  = terraform.workspace == "aws_prod" ? 1 : 0
  vpc_id = aws_vpc.vpc[count.index].id

  tags = {
    Name = "Terraform_IG"
  }
}
resource "aws_route_table" "r" {
  count  = terraform.workspace == "aws_prod" ? 1 : 0
  vpc_id = aws_vpc.vpc[count.index].id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw[count.index].id
  }
  tags = {
    Name = "TerraformRouteTable"
  }
}
resource "aws_route_table_association" "public" {
  count          = terraform.workspace == "aws_prod" ? 1 : 0
  subnet_id      = aws_subnet.subnet_public1_Lab1[count.index].id
  route_table_id = aws_route_table.r[count.index].id
}






