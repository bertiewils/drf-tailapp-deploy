
### ECS Security Group - ALB -> ECS, SSH -> ECS
resource "aws_security_group" "apphost-sg" {
  name        = "apphost-sg"
  description = "Allow HTTP, HTTPS and SSH traffic"

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


resource "aws_instance" "apphost1" {
  ami           = "ami-050949f5d3aede071"
  instance_type = "t2.micro"
  user_data = "${file("cloudinit.sh")}"
  tags = {
    Type = "apphost"
  }
  vpc_security_group_ids = [
    aws_security_group.apphost-sg.id
  ]
}
