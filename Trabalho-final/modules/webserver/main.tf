resource "aws_instance" "web" {
  count = var.instance_count

  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"

  tags = {
    Name = "${format("nginx-${terraform.workspace}-%03d", count.index + 1)}"
  }

  user_data = <<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y nginx
              EOF
}

resource "aws_elb" "web" {
  name = "elb-${terraform.workspace}"
  
  instances = aws_instance.web[*].id
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port          = 80
    lb_protocol      = "http"
  }
}

resource "aws_security_group" "web" {
  name = "sg-web-${terraform.workspace}"
  
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}