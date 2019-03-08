provider "aws" {
  region = "${var.region}"

  #access_key = "${var.aws_access_key}"
  #secret_key = "${var.aws_secret_key}"
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-xenial-16.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

resource "aws_instance" "instance" {
  instance_type     = "${var.instance_type}"
  ami               = "${data.aws_ami.ubuntu.id}"
  availability_zone = "${var.availability_zones}"
  #security_groups = ["${aws_security_group.allow_some.name}"] 
  vpc_security_group_ids = ["${aws_security_group.allow_some.id}"]
  key_name  = "${aws_key_pair.deployer.id}"
  subnet_id = "${aws_subnet.public.id}"

  root_block_device {
    volume_size = "${var.disk_size}"
  }

  lifecycle {
    create_before_destroy = true
  }

  # Provisioning

  connection {
    user        = "cmsc"
    private_key = "${file(var.private_key_path)}"
  }
}

resource "aws_key_pair" "deployer" {
  key_name   = "deployer-key"
  public_key = "${file(var.public_key_path)}"
}

terraform {
  backend "s3" {
    bucket = "timesinternet-test"
    key    = "terraform/dev/test/terraform_dev.tfstate"
    region = "ap-south-1"
  }
}

output "image_id" {
  value = "${data.aws_ami.ubuntu.id}"
}
