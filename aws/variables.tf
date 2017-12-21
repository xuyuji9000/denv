variable "access_key" {}
variable "secret_key" {}
variable "region" {
    default = "cn-north-1"
}
variable "ami" {
    default = "ami-a163b4cc"
}
variable "instance_type" {
	default = "t2.micro"
}