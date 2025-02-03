terraform {
  source = "${get_repo_root()}//modules/oci/identity/compartment"
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  name          = "k8s-always-free"
  description   = "k8s-always-free"
  enable_delete = true
}
