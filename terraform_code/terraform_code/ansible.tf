resource "aws_instance" "Ansible_controller_node" {
  count = terraform.workspace == "aws_prod" ? 1 : 0

  ami           = lookup(var.image, terraform.workspace)
  instance_type = lookup(var.type, terraform.workspace)

  availability_zone      = element(var.az, count.index)
  subnet_id              = aws_subnet.subnet_public1_Lab1[count.index].id
  vpc_security_group_ids = [aws_security_group.TerraformSG[count.index].id]
  key_name               = "anuj-aws-key"
  tags = {
    Environment = var.environment_tag
    Name        = var.OSNames[0]

  }

  provisioner "file" {
    source      = "./main1.yml"
    destination = "/home/ec2-user/main1.yml"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }
  provisioner "file" {
    source      = "./main2.yml"
    destination = "/home/ec2-user/main2.yml"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }

  provisioner "file" {
    source      = "./ec2.py"
    destination = "/home/ec2-user/ec2.py"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }

  provisioner "file" {
    source      = "./ec2.ini"
    destination = "/home/ec2-user/ec2.ini"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }
  provisioner "file" {
    source      = "./ansible.cfg"
    destination = "/home/ec2-user/ansible.cfg"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }

  provisioner "file" {
    source      = "./key000000.pem"
    destination = "/home/ec2-user/key000000.pem"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }


  provisioner "file" {
    source      = "./mainplaybook.yml"
    destination = "/home/ec2-user/mainplaybook.yml"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }
  provisioner "file" {
    source      = "./nodeapp.yml"
    destination = "/home/ec2-user/nodeapp.yml"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }
  provisioner "file" {
    source      = "./node_playbook.yml"
    destination = "/home/ec2-user/node_playbook.yml"
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }
  }

  provisioner "remote-exec" {
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("./key000000.pem")
      host        = aws_instance.Ansible_controller_node[count.index].public_ip
    }

    inline = [
      "sudo sudo yum install https://dl.fedoraproject.org/pub/epel/epel-release-latest-8.noarch.rpm -y",
      "sudo sudo yum install ansible -y",
      "sudo yes | cp /home/ec2-user/ansible.cfg   /etc/ansible/ansible.cfg",
      "sudo yum install java-1.8.0-openjdk-devel -y",
      "sudo yum install git -y",
      "sudo pip3 install boto boto3",
      "sudo mkdir /my_inventory",
      "sudo yum install wget -y",
      "sudo mv  /home/ec2-user/ec2.ini  /my_inventory/",
      "sudo mv  /home/ec2-user/ec2.py  /my_inventory/",
      "sudo yum install httpd -y",
      "sudo chmod  +x /my_inventory/ec2.py",
      "sudo chmod  +x /my_inventory/ec2.ini",
      "sudo mv /home/ec2-user/ansible.cfg   /etc/ansible/ansible.cfg",
      "export AWS_REGION='ap-south-1'",
      "export AWS_ACCESS_KEY_ID='AKIA5DFDL7WNUTSHF37M'",
      "export AWS_SECRET_ACCESS_KEY='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'",
      "chmod  400 /home/ec2-user/key000000.pem",
      "sudo ansible all -m ping",
      "sudo ansible-galaxy init /home/ec2-user/master",
      "sudo ansible-galaxy init /home/ec2-user/slave",
      "sudo ansible-galaxy init /home/ec2-user/nodeapp",
      "sudo  mv /home/ec2-user/main1.yml   /home/ec2-user/master/tasks/main.yml",
      "sudo  mv /home/ec2-user/main2.yml   /home/ec2-user/slave/tasks/main.yml",
      "sudo mv /home/ec2-user/nodeapp.yml   /home/ec2-user/nodeapp/tasks/main.yml",
      "ansible-playbook   /home/ec2-user/mainplaybook.yml",
      "ansible-playbook   /home/ec2-user/node_playbook.yml"
 

    ]
  }

}
