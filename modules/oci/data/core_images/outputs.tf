output "images" {
  description = "A list of images that match the query."
  value       = data.oci_core_images.this.images
}
