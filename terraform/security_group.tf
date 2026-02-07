resource "yandex_vpc_security_group" "n8n-sg-balancer" {
  name        = "n8n-sg-balancer"
  description = "HTTP/HTTPS + healthchecks + all egress"
  network_id  = data.yandex_vpc_network.default.id

  egress {
    protocol       = "ANY"
    description    = "any"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-http"
    port           = 80
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol       = "TCP"
    description    = "ext-https"
    port           = 443
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    protocol          = "TCP"
    description       = "healthchecks"
    port              = 30080
    predefined_target = "loadbalancer_healthchecks"
  }
}

resource "yandex_vpc_security_group" "n8n-sg-vms" {
  name        = "n8n-sg-vms"
  description = "HTTP/HTTPS + healthchecks + all egress"
  network_id  = data.yandex_vpc_network.default.id

  ingress {
    protocol          = "TCP"
    description       = "balancer"
    port              = 80
    security_group_id = yandex_vpc_security_group.n8n-sg-balancer.id

  }

  ingress {
    protocol       = "TCP"
    description    = "ssh"
    port           = 22
    v4_cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    protocol       = "ANY"
    description    = "all-egress"
    v4_cidr_blocks = ["0.0.0.0/0"]
  }
}
