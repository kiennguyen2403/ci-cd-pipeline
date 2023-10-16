# main.tf

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.27"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region  = "ap-southeast-2"
}



resource "aws_instance" "app" {
  ami           = "ami-00e734696834c1dcc"
  instance_type = "t4g.small"
  key_name = "assignment"
  security_groups = ["test"]

  tags = {
    Name = "testServer"
  }
}


# Provision the instance
resource "null_resource" "docker" {
  triggers = {
    instance_id = aws_instance.app.id
  }

  connection {
    type        = "ssh"
    host        = aws_instance.app.public_ip
    user        = "ec2-user"
    private_key = file("./key/assignment2.pem")
  }

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install docker -y",
      "sudo service docker start",
      "sudo chkconfig docker on",
      "sudo yum install -y git",
      "sudo curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "sudo chmod +x /usr/local/bin/docker-compose",
      "sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose"
    ]
  }
}

# Define Docker Compose configuration
resource "null_resource" "docker_run" {
  depends_on = [null_resource.docker]

  connection {
    type        = "ssh"
    host        = aws_instance.app.public_ip
    user        = "ec2-user"
    private_key = file("./key/assignment2.pem")

  }

  provisioner "file" {
    source      = "../docker/docker-compose.yml"  # Replace with your Docker Compose file
    destination = "/home/ec2-user/docker-compose.yml"
  }
  # comment
  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user",
      "sudo docker-compose up -d",
    ]
  }
}