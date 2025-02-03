terraform {
  source = "${get_repo_root()}//modules/oci/data/identity/fault_domains"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

dependency "availability_domains" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/identity/availability_domains"
}

inputs = {
  compartment_id      = dependency.compartment.outputs.id
  availability_domain = dependency.availability_domains.outputs.availability_domains[0].name
}
