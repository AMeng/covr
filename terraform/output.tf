output "ca_cert" {
  value = "${tls_self_signed_cert.covr.cert_pem}"
}
