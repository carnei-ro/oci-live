resource "oci_core_default_security_list" "this" {
  manage_default_resource_id = var.manage_default_resource_id


  ingress_security_rules {
    protocol = "all"
    source   = var.ingress_security_rules_source
  }

  egress_security_rules {
    protocol    = "all"
    destination = "0.0.0.0/0"
  }
}
