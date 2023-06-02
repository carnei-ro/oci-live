output "controlplane_yaml_b64" {
  value       = base64encode(data.local_file.controlplane_yaml.content)
  description = "The base64-encoded controlplane.yaml file."
}

output "worker_yaml_b64" {
  value       = base64encode(data.local_file.worker_yaml.content)
  description = "The base64-encoded worker.yaml file."
}

output "talosconfig_b64" {
  value       = base64encode(data.local_sensitive_file.talosconfig.content)
  description = "The base64-encoded talosconfig file."
  sensitive   = true
}
