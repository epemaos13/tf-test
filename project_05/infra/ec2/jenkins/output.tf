output "public_ip" {
  description = "The Public IP on the Instance"
  value       = aws_instance.jenkins.public_ip
}
output "jenkins_id" {
  description = "The ID of the Instance"
  value       = aws_instance.jenkins.id
}