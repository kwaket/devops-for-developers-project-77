resource "datadog_monitor" "app_health" {
  name = "App HTTP Health Check"
  type = "service check"

  query   = <<EOT
  "http.can_connect".over("*").by("host").last(5).count_by_status()
  EOT
  message = "HTTP check failed! Check the host {{host}}"

  monitor_thresholds {
    critical = 5
    warning  = 3
    ok       = 0
  }

}
