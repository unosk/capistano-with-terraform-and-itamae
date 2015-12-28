resource "aws_route53_zone" "main" {
  name = "example.com"
  tags {
    Project = "${var.project}"
  }
}

resource "aws_route53_record" "main" {
   zone_id = "${aws_route53_zone.main.zone_id}"
   name    = "example.com"
   type    = "A"
   ttl     = "300"
   records = ["${aws_eip.web.public_ip}"]
}
