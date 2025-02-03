terraform {
  source = "${get_repo_root()}//modules/oci/objectstorage/bucket"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

dependency "objectstorage_namespace" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/objectstorage/namespace"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id
  namespace      = dependency.objectstorage_namespace.outputs.namespace
  name           = "talos-image"
  access_type    = "NoPublicAccess"
  auto_tiering   = "InfrequentAccess"
  versioning     = "Disabled"
}
