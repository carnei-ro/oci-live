output "image_id" {
  value       = try(data.oci_core_images.this.images[0].id, null)
  description = "The OCID of the first match."
}

output "images" {
  value       = try(data.oci_core_images.this.images, null)
  description = "The full list of images."
}
