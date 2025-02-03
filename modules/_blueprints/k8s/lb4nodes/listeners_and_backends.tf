locals {
  listeners_and_backends_per_instance = flatten([
    for instance_ip_address in var.backend_instances : [
      for key, listener_and_backend in var.listeners_and_backends : {
        balancer_set_name    = key
        listener_and_backend = listener_and_backend
        instance_ip_address  = instance_ip_address
      }
    ]
  ])

  backends = {
    for lb in local.listeners_and_backends_per_instance :
    format("%s:%s", lb.instance_ip_address, lb.listener_and_backend.backend_port) => lb
  }
}

resource "oci_load_balancer_backend_set" "this" {
  for_each = var.listeners_and_backends

  health_checker {
    protocol = "TCP"
  }
  load_balancer_id = oci_load_balancer_load_balancer.this.id
  name             = each.key
  policy           = each.value.balancer_policy
}

resource "oci_load_balancer_listener" "this" {
  for_each = var.listeners_and_backends

  default_backend_set_name = oci_load_balancer_backend_set.this[each.key].name
  load_balancer_id         = oci_load_balancer_load_balancer.this.id
  name                     = each.key
  port                     = each.value.listener_port
  protocol                 = "TCP"
}

resource "oci_load_balancer_backend" "this" {
  for_each = local.backends

  backendset_name  = oci_load_balancer_backend_set.this[each.value.balancer_set_name].name
  load_balancer_id = oci_load_balancer_load_balancer.this.id
  ip_address       = each.value.instance_ip_address
  port             = each.value.listener_and_backend.backend_port
}
