resource "aws_security_group" "instance_security_group" {
  vpc_id      = var.settings.vpc_id
  name        = "${var.service_name}_instance_security_group"
  description = "security group that allows all ingress from alb"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    security_groups = [aws_security_group.alb_security_group.id]
  }
  tags = {
    Name = "${var.service_name}_instance_security_group"
  }
}

resource "aws_security_group" "alb_security_group" {
  vpc_id      = var.settings.vpc_id
  name        = "${var.service_name}_alb_security_group"
  description = "security group that allows all ingress and all egress traffic"
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "${var.service_name}_alb_security_group"
  }
}
