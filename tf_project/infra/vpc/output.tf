output "vpc_id" {
  value = aws_vpc.aws18-vpc.id
}
output "public-subnet-2a-id" {
  value = aws_subnet.aws18-public-subnet-2a.id
}
output "public-subnet-2c-id" {
  value = aws_subnet.aws18-public-subnet-2c.id
}
output "private-subnet-2a-id" {
  value = aws_subnet.aws18-private-subnet-2a.id
}
output "private-subnet-2c-id" {
  value = aws_subnet.aws18-private-subnet-2c.id
}