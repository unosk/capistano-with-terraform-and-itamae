resource "aws_s3_bucket" "main" {
  bucket = "${var.s3_bucket_name}"
  acl    = "private"
  tags {
    Project = "${var.project}"
  }
}
