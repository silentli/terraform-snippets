# Nginx EC2 Layer Outputs

output "asg_id" {
  description = "ID of the Auto Scaling Group"
  value       = aws_autoscaling_group.nginx.id
}

output "asg_name" {
  description = "Name of the Auto Scaling Group"
  value       = aws_autoscaling_group.nginx.name
}

output "asg_arn" {
  description = "ARN of the Auto Scaling Group"
  value       = aws_autoscaling_group.nginx.arn
}

output "launch_template_id" {
  description = "ID of the launch template"
  value       = aws_launch_template.nginx.id
}
