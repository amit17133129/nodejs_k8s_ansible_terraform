# variable "instance_type" {

#   default = "t2.micro"
#   type    = string
# }

# output "o1" {
#   value = var.instance_type
# }


#variable "is_testing" {
#  type        = bool
#  description = "Do you wanted to deploy in production ? "
#}

# decalring instance type variables 
# variable "instance_type" {}

#variable "m_type" {}

# declaring avalibility zone variable
variable "az" {
  type    = list(string)
  default = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]

}
variable "subnet_names" {
  type    = list(string)
  default = ["subnet-1", "subnet-2", "subnet-3"]

}


variable "instance_types" {
  type = map(any)
  default = {
    us-east-1  = "t2.nano",
    ap-south-1 = "t2.medium",
    us-west-1  = "t2.micro"
  }
}

variable "master_node" {
  type = map(any)
  default = {
    aws_prod = "t2.medium"
  }
}

#  ---------------------------- azure  variables ----------------------------
variable "type" {
  type = map(any)
  default = {
    aws_prod   = "t2.micro"
    azure_prod = "OpenLogic"
    gcp_dev        = "e2-medium"
  }
}

variable "publi_ip_names" {
     type = list(any)
     default = ["masterPublicIP", "slave1PublicIP", "slave2PublicIP"]
     }
variable "NIC_cards" {
     type = list(any)
     default = ["masterNIC", "slave1NIC", "slave2NIC"]
     }

variable "Disk_names" {
     type = list(any)
     default = ["masterOsDisk", "slave1OsDisk", "slave2OsDisk"]
     }

variable "vm_names" {
     type = list(any)
     default = ["JenkinsMaster", "JenkinsSlave1", "JenkinsSlave2"]
     }

variable "vm_password" {
     type = list(any)
     default = ["azure@123"]
     }

variable "vm_user" {
     type = list(any)
     default = ["azureusermaster", "azureuserslave1", "azureuserslave2"]
     }

variable "image" {
  type = map(any)
  default = {
    aws_prod   = "ami-06a0b4e3b7eb7a300"
    azure_prod = "CentOS"
    gcp_dev    = "centos-cloud/centos-7"
  }
}


#  ---------------------------- aws  variables ----------------------------
variable "cidr_vpc" {
  description = "CIDR block for the VPC"
  default     = "192.168.0.0/16"
}

variable "cidr_subnet1" {
  description = "CIDR block for the subnet"
  default     = "192.168.1.0/24"
}


variable "availability_zone" {
  description = "availability zone to create subnet"
  default     = "ap-south-1"
}


variable "environment_tag" {
  description = "Environment tag"
  default     = "Production"

}


variable "OSNames" {
  type    = list(string)
  default = ["Ansible_controller_node", "K8S_Master", "K8S_Slave1", "K8S_Slave2"]

}



