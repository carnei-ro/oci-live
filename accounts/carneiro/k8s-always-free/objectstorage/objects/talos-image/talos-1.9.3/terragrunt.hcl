terraform {
  source = "${get_repo_root()}//modules/oci/objectstorage/object"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "image_file" {
  config_path = "${get_repo_root()}/accounts/carneiro/_data/oci-images/talos-1.9.3"
}

dependency "objectstorage_namespace" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/objectstorage/namespace"
}

dependency "bucket" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/objectstorage/buckets/talos-image"
}

inputs = {
  bucket        = dependency.bucket.outputs.bucket_name
  namespace     = dependency.bucket.outputs.bucket_namespace
  object        = replace(dependency.image_file.outputs.artifact_name, "/^\\/tmp\\//", "")
  object_source = dependency.image_file.outputs.artifact_name
  content_md5   = filemd5(dependency.image_file.outputs.artifact_name)
}
