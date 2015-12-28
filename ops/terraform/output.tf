output "app_access_key_id" {
  value = "${aws_iam_access_key.app.id}"
}
output "app_secret_access_key" {
  value = "${aws_iam_access_key.app.secret}"
}
