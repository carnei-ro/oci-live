resource "oci_objectstorage_object" "this" {
  bucket      = var.bucket
  namespace   = var.namespace
  object      = var.object
  source      = var.object_source
  content_md5 = var.content_md5
}
