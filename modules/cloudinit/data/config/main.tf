data "cloudinit_config" "this" {
  base64_encode = var.base64_encode
  gzip          = var.gzip
  boundary      = var.boundary

  dynamic "part" {
    for_each = var.parts

    content {
      content = part.value.content

      content_type = try(part.value.content_type, "text/plain")
      filename     = try(part.value.filename, null)
      merge_type   = try(part.value.merge_type, null)
    }
  }
}
