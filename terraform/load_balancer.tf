locals {
  domain_name = "n8n.${trim(data.yandex_dns_zone.savangard.zone, ".")}"
}

resource "yandex_alb_backend_group" "n8n-bg" {
  name = "n8n-bg"

  http_backend {
    name             = "n8n-backend"
    port             = 80
    target_group_ids = [yandex_alb_target_group.n8n-tg.id]
    healthcheck {
      timeout             = "3s"
      interval            = "10s"
      healthcheck_port    = 80
      healthy_threshold   = 2
      unhealthy_threshold = 2
      http_healthcheck {
        path = "/"
      }
    }
    http2 = "false"
  }
}

resource "yandex_alb_http_router" "n8n-router" {
  name = "n8n-router"
}

resource "yandex_alb_virtual_host" "n8n-host" {
  name           = "n8n-host"
  http_router_id = yandex_alb_http_router.n8n-router.id
  route {
    name = "n8n-route"
    http_route {
      http_match {
        path {
          prefix = "/"
        }
      }
      http_route_action {
        backend_group_id  = yandex_alb_backend_group.n8n-bg.id
        timeout           = "60s"
        auto_host_rewrite = false
      }
    }
  }

  authority = [local.domain_name]
}

resource "yandex_alb_load_balancer" "n8n-alb" {
  name               = "n8n-alb"
  network_id         = data.yandex_vpc_network.default.id
  security_group_ids = [yandex_vpc_security_group.n8n-sg-balancer.id]

  allocation_policy {
    location {
      zone_id   = var.yc_zone
      subnet_id = yandex_vpc_subnet.n8n-subnet.id
    }
  }

  listener {
    name = "n8n-listener-http"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.n8n-static-ip.external_ipv4_address[0].address
        }
      }
      ports = [80]
    }
    http {
      redirects {
        http_to_https = true
      }
    }
  }

  listener {
    name = "n8n-listener-https"
    endpoint {
      address {
        external_ipv4_address {
          address = yandex_vpc_address.n8n-static-ip.external_ipv4_address[0].address
        }
      }
      ports = [443]
    }
    tls {
      default_handler {
        http_handler {
          http_router_id = yandex_alb_http_router.n8n-router.id
        }
        certificate_ids = [data.yandex_cm_certificate.n8n-cert.id]
      }
      sni_handler {
        name         = "n8n-sni"
        server_names = [local.domain_name]
        handler {
          http_handler {
            http_router_id = yandex_alb_http_router.n8n-router.id
          }
          certificate_ids = [data.yandex_cm_certificate.n8n-cert.id]
        }
      }
    }
  }

  log_options {
    disable = true
  }
}
