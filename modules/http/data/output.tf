output "id" {
  description = "The URL used for the request."
  value       = data.http.this.id
}

output "response_body" {
  description = "The response body returned as a string."
  value       = data.http.this.response_body
}

output "response_body_base64" {
  description = "The response body encoded as base64 (standard) as defined in RFC 4648."
  value       = data.http.this.response_body_base64
}

output "response_headers" {
  description = "A map of response header field names and values. Duplicate headers are concatenated according to RFC2616."
  value       = data.http.this.response_headers
}

output "status_code" {
  description = "The HTTP response status code."
  value       = data.http.this.status_code
}
