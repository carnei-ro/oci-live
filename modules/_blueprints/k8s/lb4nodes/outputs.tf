output "loadbalancer_id" {
  description = "The OCID of the load balancer."
  value       = oci_load_balancer_load_balancer.this.id
}

output "ip_address_details" {
  description = "The IP addresses of the load balancer."
  value       = oci_load_balancer_load_balancer.this.ip_address_details
}
