terraform {
  source = "${get_repo_root()}//modules/oci/identity/policy"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

dependency "dynamic_group" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/identity/dynamic-groups/k8s-nodes"
}

dependency "kms_key" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/kms/keys/free/key-for-hashicorp-vault"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id
  name           = "allow-interact-with-kms"
  description    = "Allow instances to interact with KMS (Vault) and NSG"

  statements = [
    # TODO: policy based on tag is not working
    # format("Allow dynamic-group %s to manage network-security-groups in compartment %s where target.resource.tag.Custom-Tags.ManagedBy='Dynamic-Group/%s'",
    #   dependency.dynamic_group.outputs.name,
    #   dependency.compartment.outputs.name,
    #   dependency.dynamic_group.outputs.name,
    # )
    format("Allow dynamic-group %s to use keys in compartment %s where target.key.id = '%s'",
      dependency.dynamic_group.outputs.name,
      dependency.compartment.outputs.name,
      dependency.kms_key.outputs.id
    ),
    format("Allow dynamic-group %s to manage network-security-groups in compartment %s",
      dependency.dynamic_group.outputs.name,
      dependency.compartment.outputs.name
    ),
  ]
}
