terraform {
  source = "${get_repo_root()}//modules/oci/kms/vault"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id
  display_name   = "free"
  name           = "talos-image"
  vault_type     = "DEFAULT"
}
