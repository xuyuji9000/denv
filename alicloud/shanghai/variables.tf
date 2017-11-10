variable "access_key" {}
variable "secret_key" {}
variable "region" {}

variable "vpc_cidr" {
    default = "172.16.0.0/12"
}

variable "vswitch_cidr" {
    default = "172.16.0.0/16"
}

variable "key_name" {
    default = "key-pair-from-terraform"
}

variable "key_file" {
    default = "private.pem"
}
