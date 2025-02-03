terraform {
  source = "${get_repo_root()}//modules/_blueprints/talos/oci-image-file"
}

include {
  path = find_in_parent_folders("root.hcl")
}

inputs = {
  talos_version = "v1.9.3"
}
