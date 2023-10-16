# main.tf

provider "aws" {
  region = "us-east-1"  # Change this to your desired AWS region
}

resource "aws_instance" "example" {
  ami           = "ami-0e812285fd54f7620"
  instance_type = "t2.micro"

  tags = {
    Name = "ExampleAppServerInstance"
  }
}

# Open SSH port
resource "aws_security_group" "example" {
  name        = "example"
  description = "Example security group"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Provision the instance
resource "null_resource" "docker" {
  triggers = {
    instance_id = aws_instance.example.id
  }

  connection {
    type        = "ssh"
    host        = aws_instance.example.public_ip
    user        = "ec2-user"
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
  }
}

# Define Docker Compose configuration
resource "null_resource" "docker_run" {
  depends_on = [null_resource.docker]

  connection {
    type        = "ssh"
    host        = aws_instance.example.public_ip
    user        = "ec2-user"
  }

  provisioner "file" {
    source      = "../docker/docker-compose.yml"  # Replace with your Docker Compose file
    destination = "/home/ec2-user/docker-compose.yml"
  }

  provisioner "remote-exec" {
    inline = [
      "cd /home/ec2-user",
      "docker-compose up -d",
    ]
  }
}
