terraform {
  source = "${get_repo_root()}/modules/oci/networking/default_security_list"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vcn" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/vcn"
}

inputs = {
  manage_default_resource_id    = dependency.vcn.outputs.vcn_all_attributes.default_security_list_id
  ingress_security_rules_source = dependency.vcn.outputs.vcn_all_attributes.cidr_block
}
