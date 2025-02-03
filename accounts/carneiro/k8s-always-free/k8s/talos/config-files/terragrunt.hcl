terraform {
  source = "${get_repo_root()}//modules/_blueprints/talos/config-files"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "vcn" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/vcn"
}

inputs = {
  additional_sans            = ["https://api.oci-k8s.carnei.ro:6443"]
  k8s_service_account_issuer = "https://carnei-ro.github.io/k8s-public-data/oci-k8s"

  k8s_version             = "1.32.1"
  context_name            = "oci-k8s"
  k8s_pod_subnet_cidr     = "100.96.0.0/11"
  k8s_service_subnet_cidr = "100.64.0.0/13"

  # Do not edit this, unless you have a Load Balancer for the ControlPlanes.
  k8s_apiserver_endpoint = format("https://%s:6443", cidrhost(dependency.vcn.outputs.subnet_all_attributes.public.cidr_block, 100))
}
