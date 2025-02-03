output "artifact_name" {
  value = "/tmp/talos-arm64-${var.talos_version}.oci"
}

output "talos_version" {
  value = var.talos_version
}

output "display_name" {
  value = "Talos ${var.talos_version} (arm64)"
}
