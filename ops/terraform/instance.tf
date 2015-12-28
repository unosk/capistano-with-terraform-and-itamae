resource "aws_instance" "web" {
  ami                    = "${var.ami}"
  instance_type          = "t2.micro"
  key_name               = "${aws_key_pair.main.key_name}"
  subnet_id              = "${aws_subnet.public.0.id}"
  vpc_security_group_ids = ["${aws_security_group.web.id}"]
  tags {
    Name    = "${var.project}-web"
    Project = "${var.project}"
    Stages  = "${var.ec2_stage}"
    Roles   = "web,app,worker,db"
  }
}

resource "aws_eip" "web" {
  instance = "${aws_instance.web.id}"
  vpc      = true
}
