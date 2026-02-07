data "yandex_dns_zone" "savangard" {
  name = "savangard"
}

resource "yandex_dns_recordset" "n8n-dns-record" {
  zone_id = data.yandex_dns_zone.savangard.id
  name    = "n8n.${data.yandex_dns_zone.savangard.zone}"
  type    = "A"
  ttl     = 600
  data    = [yandex_vpc_address.n8n-static-ip.external_ipv4_address[0].address]
}
