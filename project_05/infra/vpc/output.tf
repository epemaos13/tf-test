output "vpc_id" {
  value = aws_vpc.project05-vpc.id
}
output "public1-subnet-2a-id" {
  value = aws_subnet.project05-public1-ap-northeast-2a.id
}
output "public2-subnet-2c-id" {
  value = aws_subnet.project05-public2-ap-northeast-2c.id
}
output "private1-subnet-2a-id" {
  value = aws_subnet.project05-private1-ap-northeast-2a.id
}
output "private2-subnet-2c-id" {
  value = aws_subnet.project05-private2-ap-northeast-2c.id
}