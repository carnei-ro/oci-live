resource "oci_objectstorage_bucket" "this" {
  compartment_id = var.compartment_id
  namespace      = var.namespace
  name           = var.name
  access_type    = var.access_type
  auto_tiering   = var.auto_tiering
  versioning     = var.versioning

  freeform_tags = var.freeform_tags
  defined_tags  = var.defined_tags
}
