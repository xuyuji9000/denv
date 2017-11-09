provider "aws" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

resource "aws_instance" "instance1" {
    ami           = "${var.ami}"
    instance_type = "t2.micro"

    key_name      = "${aws_key_pair.default.key_name}"

#    depends_on    = ["aws_s3_bucket.example"]
    security_groups = ["${aws_security_group.instance.name}"]
}

# resource "aws_eip" "ip" {
#     instance = "${aws_instance.example.id}"
# }
# 
# output "ip" {
#     value = "${aws_eip.ip.public_ip}"
# }
# 
# resource "aws_s3_bucket" "example" {
#     bucket = "terraform-getting-started-guide-yogiman"
#     acl    = "private"
# }

resource "aws_key_pair" "default" {
    key_name   = "aws"
    public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCVH8eq2yRay0NVc3LTOUEEflPhBRS2v47wXmSaOQr3J86YNeRE9xMfCZrPl2TX1l3vRb+wMTgV7PDzxwqJf1ixqytCMyZDQHILASF3fNsp0Cg2cvqd6j/gDNANfozWVleHB4HRmDdR/UB6DPZt0o1IBhdOcOQJLGRo9N3HvfNaqg1ytjaslW3OTW096Gf7sGL84eg6DEYkoPBxRRfYu9tPQXmr5ZtN/nU1dK0MF7dJL/paFD/pc2YlvtTOCmQzJ9G0Snz6VJi7lQtT1CMh6HHjQ+9mAxEaI2RTCfVOUpBKsv2Y74YVL9fH/b31UvWdaogjU5SLm1qeerNa/U1Ean21 jenkins"
}

resource "aws_security_group" "instance" {
    name = "instance"
}

resource "aws_security_group_rule" "ssh" {
    security_group_id = "${aws_security_group.instance.id}"
    
    type              = "ingress"
    from_port         = "22"
    to_port           = "22"
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "mysql" {
    security_group_id = "${aws_security_group.instance.id}"
    
    type              = "ingress"
    from_port         = "3306"
    to_port           = "3306"
    protocol          = "tcp"
    cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "access_internet" {
    security_group_id = "${aws_security_group.instance.id}"

    type        = "egress"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}

output "ip" {
    value = "${aws_instance.instance1.public_ip}"
}
