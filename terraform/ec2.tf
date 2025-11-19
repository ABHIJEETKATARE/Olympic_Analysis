#key value pair
#virtual private cloud
#security groups

resource "aws_key_pair" "olympic_analysis_key_pair" {
  key_name   = "var.olympic_analysis_key_name"
  public_key = file("olympic_analysis_key.pub")

}
resource "aws_default_vpc" "olympic_analysis_default_vpc" {
  tags = {
    Name = "olympic_analysis_default_vpc"
  }
}
resource "aws_security_group" "olympic_analysis_security_group" {
  name        = var.olympic_analysis_security_group_name
  description = var.olympic_analysis_security_group_description
  vpc_id      = aws_default_vpc.olympic_analysis_default_vpc.id
  tags = {
    Name        = "olympic_analysis_security_group"
    Environment = "dev"
  }
}
resource "aws_vpc_security_group_ingress_rule" "ingress" {
  for_each          = toset([for p in var.olympic_analysis_ingress_ports : tostring(p)])
  security_group_id = aws_security_group.olympic_analysis_security_group.id
  cidr_ipv4         = aws_default_vpc.olympic_analysis_default_vpc.cidr_block
  from_port         = tonumber(each.value)
  to_port           = tonumber(each.value)
  ip_protocol       = "tcp"
}
resource "aws_vpc_security_group_ingress_rule" "egress" {
  security_group_id = aws_security_group.olympic_analysis_security_group.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1"
}
resource "aws_instance" "olympic_analysis_instance" {
  key_name        = aws_key_pair.olympic_analysis_key_pair.key_name
  security_groups = [aws_security_group.olympic_analysis_security_group.name]
  instance_type   = var.olympic_analysis_instance_type
  ami             = var.olympic_analysis_ami_id
  root_block_device {
    volume_size = var.olympic_analysis_root_volume_size
    volume_type = var.olympic_analysis_root_volume_type
  }
  tags = {
    Name  = "olympic_anaysis_ec2_instance"
    Owner = "Admin"
  }
}
