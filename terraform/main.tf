provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  # Additional configurations like security groups, IAM roles, etc.
}

# Define other AWS resources like RDS, networking, etc.
