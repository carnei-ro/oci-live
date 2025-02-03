terraform {
  source = "${get_repo_root()}//modules/oci/compute/instance"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

dependency "vcn" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/vcn"
}

dependency "availability_domains" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/identity/availability_domains"
}

dependency "fault_domains" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/identity/fault_domains"
}

dependency "my_ip_nsg" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/networking/network-security-groups/my-ip"
}

dependency "image" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_data/oci-images/ubuntu-24.04-amd64-E2.1.Micro"
}

dependency "cloud_init" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/k8s/talos/_data/cloud-init"
}

locals {
  common = read_terragrunt_config(find_in_parent_folders("common.hcl", find_in_parent_folders(".empty.hcl"))).locals
}

inputs = {
  display_name = "talos-bootstraper"
  shape        = "VM.Standard.E2.1.Micro"

  shape_config = {
    ocpus         = 1
    memory_in_gbs = 1
  }

  metadata = {
    ssh_authorized_keys = try(local.common.ssh_authorized_keys)
    user_data           = dependency.cloud_init.outputs.rendered
  }

  source_details = {
    source_type = "image"
    source_id   = dependency.image.outputs.images[0].id
  }

  create_vnic_details = {
    assign_public_ip = true
    subnet_id        = dependency.vcn.outputs.subnet_all_attributes.public.id
    private_ip       = cidrhost(dependency.vcn.outputs.subnet_all_attributes.public.cidr_block, 200)
    nsg_ids = [
      dependency.my_ip_nsg.outputs.id,
    ]
  }

  compartment_id      = dependency.compartment.outputs.id
  availability_domain = dependency.availability_domains.outputs.availability_domains[0].name
  fault_domain        = dependency.fault_domains.outputs.fault_domains[2].name
}
