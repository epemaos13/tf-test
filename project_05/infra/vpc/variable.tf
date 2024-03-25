variable "vpc_cidr" {
  default = "10.5.0.0/16"
}
variable "public_subnet" {
  type    = list(any)
  default = ["10.5.101.0/24", "10.5.103.0/24"]
}
variable "private_subnet" {
  type    = list(any)
  default = ["10.5.1.0/24", "10.5.3.0/24"]
}
variable "azs" {
  type    = list(any)
  default = ["ap-northeast-2a", "ap-norhteast-2c"]
}