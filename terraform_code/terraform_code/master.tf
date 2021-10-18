resource "aws_instance" "Master" {
  count = terraform.workspace == "aws_prod" ? 1 : 0

  ami           = lookup(var.image, terraform.workspace)
  instance_type = lookup(var.master_node, terraform.workspace)

  availability_zone      = element(var.az, count.index)
  subnet_id              = aws_subnet.subnet_public1_Lab1[count.index].id
  vpc_security_group_ids = [aws_security_group.TerraformSG[count.index].id]
  key_name               = "anuj-aws-key"
  tags = {
    Environment = var.environment_tag
    Name        = var.OSNames[1]

  }
  provisioner "file" {
    source      = "./index.html"
    destination = "/home/ec2-user/index.html"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Master[count.index].public_ip
    }
  }

  provisioner "file" {
    source      = "./Dockerfile"
    destination = "/home/ec2-user/Dockerfile"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Master[count.index].public_ip
    }
  }
  # provisioner "remote-exec" {
  #   connection {
  #     type        = "ssh"
  #     user        = "ec2-user"
  #     private_key = file("./key000000.pem")
  #     host        = aws_instance.Master[count.index].public_ip
  #   }

  #   inline = [
  #     "sudo mkdir /nodeapp",
  #     "sudo mv /home/ec2-user/Dockerfile  /nodeapp/Dockerfile",
  #     "sudo cp /home/ec2-user/index.html  /nodeapp/index.html",
  #     "sudo docker build -t amitsharma17133129/mynodeapp:v1    /nodeapp",
  #     "sudo docker login -u amitsharma17133129  -p  ABdevilliers@17",
  #     "sudo docker push amitsharma17133129/mynodeapp:v1",
  #   ]
  #   depends_on = [
  #   aws_instance.Ansible_controller_node.remo,
  # ]
  # }

}
