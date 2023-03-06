

#########################################################
# CREATING VARIABLE BLOCK
#########################################################

variable "security_group_name" {
  type        = map(any)
  description = "passing name for the security group rules"

}

variable "from_port" {
  type        = list(any)
  description = "port number for from"
  default     = ["80", "443", ]
}

variable "to_port" {
  type        = list(any)
  description = "port number for from"
  default     = ["80", "443", ]
}

variable "cidr_block" {
  type        = list(any)
  description = "cidr block"
  default     = ["0.0.0.0/0"]
}

variable "vpc_id" {
  type        = string
  description = "passing vpc_id"

}

variable "component_name" {
  type = string
  
}