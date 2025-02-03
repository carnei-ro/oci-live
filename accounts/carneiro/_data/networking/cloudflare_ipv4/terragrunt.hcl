terraform {
  source = "${get_repo_root()}//modules/http/data"
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  url = "https://api.cloudflare.com/client/v4/ips"

  request_headers = {
    Accept = "application/json"
  }
}
