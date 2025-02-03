terraform {
  source = "${get_repo_root()}//modules/http/data"
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  url = "https://cloudflare-dns.com/dns-query?name=carnei-ro.duckdns.org&type=A"

  request_headers = {
    Accept = "application/dns-json"
  }
}
