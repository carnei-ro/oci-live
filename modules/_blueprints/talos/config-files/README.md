# Blueprint - Talos - Config Files

It needs `talosctl` binary.

<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_local"></a> [local](#provider\_local) | n/a |
| <a name="provider_null"></a> [null](#provider\_null) | n/a |
| <a name="provider_tls"></a> [tls](#provider\_tls) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [local_file.patch_all](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [local_file.patch_controlplane](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) | resource |
| [null_resource.talos_configurations](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [tls_private_key.this](https://registry.terraform.io/providers/hashicorp/tls/latest/docs/resources/private_key) | resource |
| [local_file.controlplane_yaml](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_file.worker_yaml](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/file) | data source |
| [local_sensitive_file.talosconfig](https://registry.terraform.io/providers/hashicorp/local/latest/docs/data-sources/sensitive_file) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_k8s_apiserver_endpoint"></a> [k8s\_apiserver\_endpoint](#input\_k8s\_apiserver\_endpoint) | The endpoint for the Kubernetes API server | `string` | n/a | yes |
| <a name="input_additional_sans"></a> [additional\_sans](#input\_additional\_sans) | Additional SANs to add to the TLS certificate. | `list(string)` | `[]` | no |
| <a name="input_context_name"></a> [context\_name](#input\_context\_name) | The name of the context to create | `string` | `"oci-k8s"` | no |
| <a name="input_k8s_pod_subnet_cidr"></a> [k8s\_pod\_subnet\_cidr](#input\_k8s\_pod\_subnet\_cidr) | The CIDR block for the pod subnet | `string` | `"100.96.0.0/11"` | no |
| <a name="input_k8s_service_account_issuer"></a> [k8s\_service\_account\_issuer](#input\_k8s\_service\_account\_issuer) | The issuer for the service account token | `string` | `""` | no |
| <a name="input_k8s_service_account_private_key_b64"></a> [k8s\_service\_account\_private\_key\_b64](#input\_k8s\_service\_account\_private\_key\_b64) | The private key for signing all the the service account's tokens encoded in base64. If not provided, a new key will be generated. | `string` | `null` | no |
| <a name="input_k8s_service_subnet_cidr"></a> [k8s\_service\_subnet\_cidr](#input\_k8s\_service\_subnet\_cidr) | The CIDR block for the service subnet | `string` | `"100.64.0.0/13"` | no |
| <a name="input_k8s_version"></a> [k8s\_version](#input\_k8s\_version) | The version of Kubernetes to install | `string` | `"1.32.1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_controlplane_yaml_b64"></a> [controlplane\_yaml\_b64](#output\_controlplane\_yaml\_b64) | The base64-encoded controlplane.yaml file. |
| <a name="output_k8s_service_account_private_key_b64"></a> [k8s\_service\_account\_private\_key\_b64](#output\_k8s\_service\_account\_private\_key\_b64) | The base64-encoded private key for signing the service account tokens. |
| <a name="output_talosconfig_b64"></a> [talosconfig\_b64](#output\_talosconfig\_b64) | The base64-encoded talosconfig file. |
| <a name="output_worker_yaml_b64"></a> [worker\_yaml\_b64](#output\_worker\_yaml\_b64) | The base64-encoded worker.yaml file. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
