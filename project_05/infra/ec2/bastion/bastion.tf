resource "aws_instance" "bastion" {
  ami = "ami-0d3d9b94632ba1e57"
  instance_type = "t2.micro"
  key_name = "project05-key"
  // 퍼블릭 IP 활성화
  associate_public_ip_address = true
  security_groups = [data.terraform_remote_state.security_group.outputs.ssh_id]

  subnet_id = data.terraform_remote_state.vpc.outputs.public-subnet-2a-id

  tags = {
    Name = "project05-bastion-instance"
  }
}