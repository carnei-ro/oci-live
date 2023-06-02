output "response_body" {
  value = local.cloudflare_request_body
}

output "ipv4_cidrs_map" {
  value = {
    for i in local.cloudflare_request_body.result.ipv4_cidrs :
    i => {
      cidr = i
    }
  }
}

output "ipv6_cidrs_map" {
  value = {
    for i in local.cloudflare_request_body.result.ipv6_cidrs :
    i => {
      cidr = i
    }
  }
}

output "ipv4_cidrs" {
  value = local.cloudflare_request_body.result.ipv4_cidrs
}

output "ipv6_cidrs" {
  value = local.cloudflare_request_body.result.ipv6_cidrs
}
