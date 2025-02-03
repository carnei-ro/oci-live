terraform {
  source = "${get_repo_root()}//modules/oci/compute/image"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

dependency "talos_image" {
  config_path = "${get_repo_root()}/accounts/carneiro/_data/oci-images/talos-1.9.3"
}

dependency "image_object" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/objectstorage/objects/talos-image/talos-1.9.3"
}

dependency "bucket" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/objectstorage/buckets/talos-image"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id

  display_name = dependency.talos_image.outputs.display_name
  launch_mode  = "PARAVIRTUALIZED"

  image_source_details = {
    source_type    = "objectStorageTuple"
    bucket_name    = dependency.bucket.outputs.bucket_name
    namespace_name = dependency.bucket.outputs.bucket_namespace
    object_name    = dependency.image_object.outputs.object_name

    #Optional
    operating_system         = "Talos"
    operating_system_version = dependency.talos_image.outputs.talos_version
    source_image_type        = "QCOW2"
  }
}
