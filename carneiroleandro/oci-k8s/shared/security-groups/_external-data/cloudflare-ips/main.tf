data "http" "this" {
  url = "https://api.cloudflare.com/client/v4/ips"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  cloudflare_request_body = jsondecode(data.http.this.response_body)
}
