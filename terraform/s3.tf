resource "aws_s3_bucket" "kops" {
  bucket        = "${var.kops_bucket_name}"
  acl           = "private"
  force_destroy = true
}
