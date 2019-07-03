resource "aws_key_pair" "deployer" {
  key_name   = "denizzzzp-dev"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDYZelxip1GE6beEiQlswdXFhJgDZJ9ZOcSzI2m4rLezOYqdE97bPOIV/cehYkoxoC1cJmrrTyWpzofsQkc82v8Fj+Ktq/N3v6E9Yipy09Ng8EmWX00TXCJyzeoJ2G9cIiAXSnfITvpqJdR3H6gDaJaAIk66K5kZmrxUswf3Ug1nLIE2bMdE0D8dV5OaWWW5R+4nC9tkb9ElvGZBstk6sGuGPRrkAJ2frl8huLH0/I75v8xCjFjJ6dSFz6B4fSAgwlzl6bEiypOATkpJmsEQ1ilogID1I5edmRXpwWZxJ2YD05w19uIIJ5uT4b1O+PCYo6P/rnoUr8dEH5rCy3Tn5Xx root@DENIS-NEW"
}

data "template_file" "user_data" {
  template = "${file("templates/user_data.tpl")}"

  vars {
    package_to_install = "nginx"
    TEXT = "DENIZZZP"
  }
}

resource "aws_security_group" "alloy-web" {
  name   = "ClusterSecurityGroup"
  ingress {
    from_port         = 22
    to_port           = 22
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  ingress {
    from_port         = 80
    to_port           = 80
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  ingress {
    from_port         = 443
    to_port           = 443
    protocol          = "TCP"
    cidr_blocks       = ["0.0.0.0/0"]
  }
  egress {
    from_port         = 0
    to_port           = 0
    protocol          = "-1"
    cidr_blocks       = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "web" {
  ami           = "${var.ami_id}"
  instance_type = "t2.micro"
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.name}"
  key_name = "${aws_key_pair.deployer.key_name}"
  security_groups = ["${aws_security_group.alloy-web.name}"]
  user_data = "${data.template_file.user_data.rendered}"
}

