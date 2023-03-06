SECURITY GROUP MODULE

Creating security group module

Usage

```
module "sg" {
  source = "git::https://github.com/lekankeshaws/security-group-module.git"

  vpc_id    = data.aws_vpc.default.id
  component_name = var.component_name

  security_group_name = {    
      alb_sg = {
        name        = "${var.component_name}_alb_sg"
        description = "allow http and https to the alb"
      }
      webserver_sg = {
        name        = "${var.component_name}_webserver_security_group"
        description = "allow alb on port 80"
      }
      remote_access_sg = {
        name        = "${var.component_name}_bastion_security_group"
        description = "allow access to ssh"
      }
      database_sg = {
        name        = "${var.component_name}_database_security_group"
        description = "allow access on database port"
      }
    
  } 

}

data "aws_vpc" "default" {
  default = true
    
}
```