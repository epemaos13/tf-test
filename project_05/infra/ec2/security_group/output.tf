output "ssh_id" {
  description = "The port will use for SSH requests"
  value       = aws_security_group.ssh.id
}
output "http_id" {
  description = "The port will use for HTTP 80 requests"
  value       = aws_security_group.http.id
}
output "https_id" {
  description = "The port will use for HTTPS requests"
  value       = aws_security_group.https.id
}