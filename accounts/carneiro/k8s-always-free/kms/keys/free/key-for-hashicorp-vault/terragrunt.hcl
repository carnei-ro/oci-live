terraform {
  source = "${get_repo_root()}//modules/oci/kms/key"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

dependency "vault" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/kms/vaults/free"
}

inputs = {
  compartment_id      = dependency.compartment.outputs.id
  management_endpoint = replace(dependency.vault.outputs.management_endpoint, "https://", "")
  display_name        = "Key for Hashicorp Vault"
  key_shape = {
    algorithm = "AES"
    length    = 32
  }
}
