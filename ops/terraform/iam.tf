resource "aws_iam_user" "app" {
  name = "${var.project}-app"
  path = "/"
}

resource "aws_iam_access_key" "app" {
  user = "${aws_iam_user.app.name}"
}

resource "aws_iam_user_policy" "app" {
  name   = "${var.project}-app"
  user   = "${aws_iam_user.app.name}"
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "arn:aws:s3:::${aws_s3_bucket.main.id}",
        "arn:aws:s3:::${aws_s3_bucket.main.id}/*"
      ]
    }
  ]
}
POLICY
}
