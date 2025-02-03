# CloudInit - Data - Config

<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_cloudinit"></a> [cloudinit](#provider\_cloudinit) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [cloudinit_config.this](https://registry.terraform.io/providers/hashicorp/cloudinit/latest/docs/data-sources/config) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_parts"></a> [parts](#input\_parts) | List of blocks type which adds a file to the generated cloud-init configuration. Use multiple part blocks to specify multiple files, which will be included in order of declaration in the final MIME document.<br>  content - (String) Body content for the part.<br>  content\_type - (String) A MIME-style content type to report in the header for the part. Defaults to text/plain.<br>  filename - (String) A filename to report in the header for the part.<br>  merge\_type - (String) A value for the X-Merge-Type header of the part, to control cloud-init merging behavior. | <pre>list(object({<br>    content      = string<br>    content_type = optional(string)<br>    filename     = optional(string)<br>    merge_type   = optional(string)<br>  }))</pre> | n/a | yes |
| <a name="input_base64_encode"></a> [base64\_encode](#input\_base64\_encode) | Specify whether or not to base64 encode the rendered output. Defaults to true, and cannot be disabled if gzip is true. | `bool` | `true` | no |
| <a name="input_boundary"></a> [boundary](#input\_boundary) | Specify the Writer's default boundary separator. Defaults to MIMEBOUNDARY. | `string` | `"MIMEBOUNDARY"` | no |
| <a name="input_gzip"></a> [gzip](#input\_gzip) | Specify whether or not to gzip the rendered output. Defaults to true. | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_rendered"></a> [rendered](#output\_rendered) | n/a |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
