resource "tls_private_key" "covr" {
  algorithm = "RSA"
}

resource "tls_self_signed_cert" "covr" {
  key_algorithm     = "RSA"
  private_key_pem   = "${tls_private_key.covr.private_key_pem}"
  is_ca_certificate = true

  subject {
    common_name  = "*.elb.us-west-2.amazonaws.com"
    organization = "Covr"
  }

  validity_period_hours = 8760

  allowed_uses = [
    "any_extended",
    "cert_signing",
    "client_auth",
    "code_signing",
    "content_commitment",
    "crl_signing",
    "data_encipherment",
    "decipher_only",
    "digital_signature",
    "email_protection",
    "encipher_only",
    "ipsec_end_system",
    "ipsec_tunnel",
    "ipsec_user",
    "key_agreement",
    "key_encipherment",
    "ocsp_signing",
    "server_auth",
    "timestamping",
  ]
}

resource "aws_acm_certificate" "covr" {
  private_key      = "${tls_private_key.covr.private_key_pem}"
  certificate_body = "${tls_self_signed_cert.covr.cert_pem}"
}
