provider "alicloud" {
    access_key = "${var.access_key}"
    secret_key = "${var.secret_key}"
    region     = "${var.region}"
}

resource "alicloud_key_pair" "key_pair" {
    key_name = "${var.key_name}"
    key_file = "${var.key_file}"
}

resource "alicloud_instance" "dev" {
    availability_zone          = "${var.region}-b"
    image_id                   = "ubuntu_16_0402_64_20G_alibase_20170818.vhd"
    
    instance_type              = "ecs.n1.small"
    is_outdated                = true
    system_disk_category       = "cloud_efficiency"
    instance_name              = "web"

    internet_charge_type       = "PayByTraffic"
    internet_max_bandwidth_out = "100"
    allocate_public_ip         = true
    
    key_name                   = "${alicloud_key_pair.key_pair.id}"

    security_groups            = ["${alicloud_security_group.default.id}"]
}

resource "alicloud_security_group" "default" {
    name        = "default"
    description = "default"
}

resource "alicloud_security_group_rule" "ping" {
    type              = "ingress"
    ip_protocol       = "icmp"
    policy            = "accept"
    priority          = 1
    port_range        = "-1/-1"
    security_group_id = "${alicloud_security_group.default.id}"
    cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "web-1" {
    type              = "ingress"
    ip_protocol       = "tcp"
    port_range        = "80/80"
    policy            = "accept"
    priority          = 1
    security_group_id = "${alicloud_security_group.default.id}"
    cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "ssl" {
    type              = "ingress"
    ip_protocol       = "tcp"
    port_range        = "443/443"
    policy            = "accept"
    priority          = 1
    security_group_id = "${alicloud_security_group.default.id}"
    cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "ssh" {
    type              = "ingress"
    ip_protocol       = "tcp"
    port_range        = "22/22"
    policy            = "accept"
    priority          = 1
    security_group_id = "${alicloud_security_group.default.id}"
    cidr_ip           = "0.0.0.0/0"
}

resource "alicloud_security_group_rule" "mysql" {
    type              = "ingress"
    ip_protocol       = "tcp"
    port_range        = "3306/3306"
    policy            = "accept"
    priority          = 1
    security_group_id = "${alicloud_security_group.default.id}"
    cidr_ip           = "0.0.0.0/0"
}

output "ip" {
    value = "${alicloud_instance.dev.public_ip}"
}
