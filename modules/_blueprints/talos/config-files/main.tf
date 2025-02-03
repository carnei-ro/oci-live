locals {
  additional_sans = length(var.additional_sans) > 0 ? format("--additional-sans %s", join(",", var.additional_sans)) : ""
}

resource "tls_private_key" "this" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "patch_controlplane" {
  content = templatefile("${path.module}/templates/patch-controlplane.yaml.tpl", {
    k8s_service_account_issuer          = var.k8s_service_account_issuer
    k8s_service_account_private_key_b64 = coalesce(var.k8s_service_account_private_key_b64, base64encode(tls_private_key.this.private_key_pem))
  })
  filename = "patches/controlplane.yaml"
}

resource "local_file" "patch_all" {
  content = templatefile("${path.module}/templates/patch-all.yaml.tpl", {
    k8s_service_subnet_cidr = var.k8s_service_subnet_cidr
    k8s_pod_subnet_cidr     = var.k8s_pod_subnet_cidr
  })
  filename = "patches/all.yaml"
}

resource "null_resource" "talos_configurations" {
  triggers = {
    on_version_change = join("\n", [
      var.context_name,
      var.k8s_version,
      var.k8s_apiserver_endpoint,
      local.additional_sans,
      var.k8s_pod_subnet_cidr,
      var.k8s_service_subnet_cidr,
      var.k8s_service_account_issuer,
      base64encode(tls_private_key.this.private_key_pem),
    ])
  }

  provisioner "local-exec" {
    command = <<-EOF
      talosctl gen config ${var.context_name} \
        --kubernetes-version ${var.k8s_version} \
        ${var.k8s_apiserver_endpoint} \
        ${local.additional_sans} \
        --with-docs=false --with-examples=false \
        --config-patch @patches/all.yaml --config-patch-control-plane @patches/controlplane.yaml
    EOF
  }
  provisioner "local-exec" {
    when    = destroy
    command = "rm controlplane.yaml talosconfig worker.yaml"
  }
  depends_on = [
    local_file.patch_all,
    local_file.patch_controlplane,
  ]
}

data "local_file" "controlplane_yaml" {
  filename = "controlplane.yaml"
  depends_on = [
    null_resource.talos_configurations,
  ]
}

data "local_file" "worker_yaml" {
  filename = "worker.yaml"
  depends_on = [
    null_resource.talos_configurations,
  ]
}

data "local_sensitive_file" "talosconfig" {
  filename = "talosconfig"
  depends_on = [
    null_resource.talos_configurations,
  ]
}
