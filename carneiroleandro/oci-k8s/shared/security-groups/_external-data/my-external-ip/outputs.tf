output "ip" {
  value = local.ip
}

output "ipv4_cidrs_map" {
  value = {
    for i in local.ipv4_cidrs :
    i => {
      cidr = i
    }
  }
}

output "ipv4_cidrs" {
  value = local.ipv4_cidrs
}
