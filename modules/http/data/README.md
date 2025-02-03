# HTTP - Data Module

<!-- BEGINNING OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_http"></a> [http](#provider\_http) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [http_http.this](https://registry.terraform.io/providers/hashicorp/http/latest/docs/data-sources/http) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_url"></a> [url](#input\_url) | The URL for the request. Supported schemes are http and https. | `string` | n/a | yes |
| <a name="input_ca_cert_pem"></a> [ca\_cert\_pem](#input\_ca\_cert\_pem) | Certificate data of the Certificate Authority (CA) in PEM (RFC 1421) format. | `string` | `null` | no |
| <a name="input_insecure"></a> [insecure](#input\_insecure) | Disables verification of the server's certificate chain and hostname. Defaults to false | `bool` | `false` | no |
| <a name="input_method"></a> [method](#input\_method) | The HTTP Method for the request. Allowed methods are a subset of methods defined in RFC7231 namely, GET, HEAD, and POST. POST support is only intended for read-only URLs, such as submitting a search. | `string` | `null` | no |
| <a name="input_request_body"></a> [request\_body](#input\_request\_body) | The request body as a string. | `string` | `null` | no |
| <a name="input_request_headers"></a> [request\_headers](#input\_request\_headers) | A map of request header field names and values. | `map(string)` | `{}` | no |
| <a name="input_request_timeout_ms"></a> [request\_timeout\_ms](#input\_request\_timeout\_ms) | (Number) The request timeout in milliseconds. | `number` | `null` | no |
| <a name="input_retry"></a> [retry](#input\_retry) | Retry request configuration. By default there are no retries. Configuring this block will result in retries if an error is returned by the client (e.g., connection errors) or if a 5xx-range (except 501) status code is received."<br><br>`attempts` - (Number) The number of times the request is to be retried. For example, if 2 is specified, the request will be tried a maximum of 3 times.<br>`max_delay_ms` - (Number) The maximum delay between retry requests in milliseconds.<br>`min_delay_ms` - (Number) The minimum delay between retry requests in milliseconds. | <pre>object({<br>    attempts     = optional(number, null)<br>    max_delay_ms = optional(number, null)<br>    min_delay_ms = optional(number, null)<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The URL used for the request. |
| <a name="output_response_body"></a> [response\_body](#output\_response\_body) | The response body returned as a string. |
| <a name="output_response_body_base64"></a> [response\_body\_base64](#output\_response\_body\_base64) | The response body encoded as base64 (standard) as defined in RFC 4648. |
| <a name="output_response_headers"></a> [response\_headers](#output\_response\_headers) | A map of response header field names and values. Duplicate headers are concatenated according to RFC2616. |
| <a name="output_status_code"></a> [status\_code](#output\_status\_code) | The HTTP response status code. |
<!-- END OF PRE-COMMIT-OPENTOFU DOCS HOOK -->
