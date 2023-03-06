

#########################################################
# CREATING SECURITY MODULE
#########################################################

resource "aws_security_group" "security" {
  for_each    = var.security_group_name
  name        = each.value.name
  description = each.value.description
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "${var.component_name}_${each.key}"
  }
}

resource "aws_security_group_rule" "ingress_rule_alb" {
  count = length(var.from_port)
  type  = "ingress"

  from_port         = element(var.from_port, count.index)
  to_port           = element(var.to_port, count.index)
  protocol          = "tcp"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.security["alb_sg"].id

}

resource "aws_security_group_rule" "ingress_rule_webserver" {
  count = length(var.from_port)
  type  = "ingress"

  from_port                = element(var.from_port, count.index)
  to_port                  = element(var.to_port, count.index)
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.security["alb_sg"].id
  security_group_id        = aws_security_group.security["webserver_sg"].id
}

resource "aws_security_group_rule" "ingress_rule_remote_access" {
  type = "ingress"

  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = var.cidr_block
  security_group_id = aws_security_group.security["remote_access_sg"].id
}

resource "aws_security_group_rule" "ingress_rule_database" {
  type = "ingress"

  from_port                = 3306
  to_port                  = 3306
  protocol                 = "tcp"
  source_security_group_id = aws_security_group.security["webserver_sg"].id
  security_group_id        = aws_security_group.security["database_sg"].id
}

# resource "aws_security_group_rule" "egress_rule" {
#   count = length(var.from_port)
#   type              = "egress"
#   to_port           = element(var.port, count.index)
#   protocol          = var.protocol
#   cidr_blocks       = var.cidr_block
#   from_port         = element(var.port, count.index)
#   security_group_id = element(aws_security_group.security[*].id, count.index)
# }