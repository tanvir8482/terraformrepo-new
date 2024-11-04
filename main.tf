provider "aws" provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "amazon-linux-instance" {
  count = 1
  ami = "ami-0583d8c7a9c35822c"
  instance_type = "t2.medium"
  key_name = "newkeypair"
  vpc_security_group_ids = [aws_security_group.default.id]
  tags = {
    Name = "test"
  }
}

resource "aws_security_group" "default" {
  name = "allow http-ssh-"
  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow jenkins-server"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    description = "all traffic"
    from_port   = 0
    to_port     = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
