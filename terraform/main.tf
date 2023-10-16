# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-2"
}

resource "aws_key_pair" "my_key" {
  key_name   = "ass2keypair"
  public_key = file("ass2keypair.pem")
}

resource "aws_instance" "app" {
  ami           = "ami-0e812285fd54f7620"
  instance_type = "t2.micro"
  key_name      = aws_key_pair.my_key.key_name

  tags = {
    Name = "ExampleAppServerInstance"
  }


  provisioner "remote-exec" {
    
    inline = [
      "sudo yum update -y",
      "sudo amazon-linux-extras install docker",
      "sudo systemctl start docker",
      "sudo systemctl enable docker",
      "sudo usermod -aG docker ec2-user",
      "sudo systemctl start docker",
      "sudo yum install -y docker-compose",
    ]
    
    connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("ass2keypair.pem")
    host = self.public_ip
    }
  }
}

