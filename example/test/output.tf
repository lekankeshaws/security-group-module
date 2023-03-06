
output "sg_id" {
    value = module.sg.security  
}

output "sg_arn" {
    value = module.sg.security_gp_arn  
}

output "sg_name" {
    value = module.sg.security_gp_name
  
}