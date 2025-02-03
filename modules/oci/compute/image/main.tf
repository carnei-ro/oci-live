resource "oci_core_image" "this" {
  compartment_id = var.compartment_id

  display_name = var.display_name
  launch_mode  = var.launch_mode

  image_source_details {
    source_type    = var.image_source_details.source_type
    namespace_name = var.image_source_details.namespace_name
    bucket_name    = var.image_source_details.bucket_name
    object_name    = var.image_source_details.object_name

    operating_system         = var.image_source_details.operating_system
    operating_system_version = var.image_source_details.operating_system_version
    source_image_type        = var.image_source_details.source_image_type
  }

  defined_tags  = var.defined_tags
  freeform_tags = var.freeform_tags
}
