resource "aws_key_pair" "terra_auto_key" {

  key_name = "terra-automate-key"
  public_key = file("terra-automate-key.pub") 

}

resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "my_sg" {

  name = "terra-sg"
  vpc_id = aws_default_vpc.default.id
  
  tags = {
    Name = "Terra-SG"
  }

}

resource "aws_vpc_security_group_ingress_rule" "allow_https" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}	

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = aws_default_vpc.default.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.my_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_instance" "terra_instance" {

  ami = "ami-05d2d839d4f73aafb"
  instance_type = "t3.micro"
  vpc_security_group_ids = [aws_security_group.my_sg.id]
  key_name = aws_key_pair.terra_auto_key.key_name

  root_block_device {
    volume_size = "10"
    volume_type = "gp3"
  }
  
  tags = {
     Name = "terra-auto-server"
     ManagedBy = "Terraform"
  }

}
