terraform {
  source = "${get_repo_root()}//modules/oci/data/core_images"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

inputs = {
  compartment_id           = dependency.compartment.outputs.id
  shape                    = "VM.Standard.E2.1.Micro"
  operating_system         = "Canonical Ubuntu"
  operating_system_version = "24.04"
}
