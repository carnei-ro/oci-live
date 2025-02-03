terraform {
  source = "${get_repo_root()}//modules/oci/identity/dynamic-group"
}

include {
  path = find_in_parent_folders("root.hcl")
}

locals {
  tenancy = read_terragrunt_config(find_in_parent_folders("tenancy.hcl")).locals
}

inputs = {
  compartment_id = local.tenancy.tenancy_ocid
  name           = "k8s-nodes"
  description    = "Kubernetes Nodes Instances"

  matching_rule = format(
    "Any{Any {%s}}", join(", ", [
      format("instance.id = '%s'", "instance_id1"),
      format("instance.id = '%s'", "instance_id2"),
      format("instance.id = '%s'", "instance_id3"),
    ])
  )
}
