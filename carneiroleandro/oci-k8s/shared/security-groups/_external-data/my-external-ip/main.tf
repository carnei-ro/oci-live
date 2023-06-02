data "http" "this" {
  url = "https://api.ipify.org/?format=json"
  request_headers = {
    Accept = "application/json"
  }
}

locals {
  ip         = jsondecode(data.http.this.response_body).ip
  ipv4_cidr  = format("%s/32", local.ip)
  ipv4_cidrs = [local.ipv4_cidr]
}
