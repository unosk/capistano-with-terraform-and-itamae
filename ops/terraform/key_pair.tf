resource "aws_key_pair" "main" {
  key_name = "${var.project}"
  public_key = "${var.ec2_public_key}"
}
