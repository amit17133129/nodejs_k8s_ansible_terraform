resource "aws_instance" "slave1" {
  count = terraform.workspace == "aws_prod" ? 1 : 0

  ami           = lookup(var.image, terraform.workspace)
  instance_type = lookup(var.type, terraform.workspace)

  availability_zone      = element(var.az, count.index)
  subnet_id              = aws_subnet.subnet_public1_Lab1[count.index].id
  vpc_security_group_ids = [aws_security_group.TerraformSG[count.index].id]
  key_name               = "key000000"
  tags = {
    Environment = var.environment_tag
    Name        = var.OSNames[2]

  }
}

resource "aws_instance" "slave2" {
  count = terraform.workspace == "aws_prod" ? 1 : 0

  ami           = lookup(var.image, terraform.workspace)
  instance_type = lookup(var.type, terraform.workspace)

  availability_zone      = element(var.az, count.index)
  subnet_id              = aws_subnet.subnet_public1_Lab1[count.index].id
  vpc_security_group_ids = [aws_security_group.TerraformSG[count.index].id]
  key_name               = "key000000"
  tags = {
    Environment = var.environment_tag
    Name        = var.OSNames[3]

  }
}
