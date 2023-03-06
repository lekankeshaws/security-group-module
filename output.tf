

output "security" {
    value = [for security in aws_security_group.security:security.id]  
}

output "security_gp_arn" {
    value = [for security in aws_security_group.security:security.arn]  
}

output "security_gp_name" {
    value = [for security in aws_security_group.security:security.name]  
}