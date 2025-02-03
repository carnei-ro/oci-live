terraform {
  source = "git::https://github.com/oracle-terraform-modules/terraform-oci-vcn.git//?ref=v3.6.0"
}

include {
  path = find_in_parent_folders("root.hcl")
}

dependency "compartment" {
  config_path = "${get_repo_root()}/accounts/carneiro/k8s-always-free/_compartment"
}

inputs = {
  compartment_id = dependency.compartment.outputs.id

  vcn_cidrs        = ["10.0.0.0/16"]
  vcn_display_name = "carneiro"

  enable_ipv6 = false

  create_internet_gateway = true
  create_nat_gateway      = true

  subnets = {
    public = {
      cidr_block = "10.0.16.0/22"
      type       = "public"
      dns_label  = "public"
    }
    private = {
      cidr_block = "10.0.8.0/21"
      type       = "private"
      dns_label  = "private"
    }
  }
}
