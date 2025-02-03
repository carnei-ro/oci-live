data "http" "this" {
  url                = var.url
  ca_cert_pem        = var.ca_cert_pem
  insecure           = var.insecure
  method             = var.method
  request_body       = var.request_body
  request_headers    = var.request_headers
  request_timeout_ms = var.request_timeout_ms

  dynamic "retry" {
    for_each = var.retry != {} ? [var.retry] : []
    content {
      attempts     = retry.value.attempts
      max_delay_ms = retry.value.max_delay_ms
      min_delay_ms = retry.value.min_delay_ms
    }
  }
}
