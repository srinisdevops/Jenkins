provider "aws" {
   region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "mybucket02222020"
    key    = "Jenkins/04/terraform.tfstate"
    region = "us-east-2"
  }
}
resource "aws_security_group" "allow_ssh" {
  name = "sg_jenkins"
  description = "Allow ssh inbound traffic"
  ingress {
      from_port = 22
      to_port = 22
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 8080
      to_port = 8080
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
      from_port = 80
      to_port = 80
      protocol = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_instance" "cZServers" {
  ami = "${lookup(var.amiid, var.region)}"
  instance_type = "t2.micro"
  count = "${var.instance_count}"
  vpc_security_group_ids = ["${aws_security_group.allow_ssh.id}"]
  tags = {
    Name = "Jenkins-${count.index + 1}"
  }

  key_name = "${var.key_name}"
  
#  provisioner "file" {
#    source      = "/home/ubuntu/.ssh/id_rsa.pub"
#    destination = "/tmp/id_rsa.pub"
#  }

  user_data = "${file("user-data.txt")}"

connection {
    type     = "ssh"
    user     = "ubuntu"
    password = ""
    private_key = "${file("~/MyKeyPair.pem")}"
  }

}

output "public_ip" {
#value = "${aws_instance.cZServers.public_ip}"
  value = "${formatlist("%v", aws_instance.cZServers.*.public_ip)}"
}

resource "null_resource" "myPublicIps" {
count = "${var.instance_count}"
provisioner "local-exec" {
      command = "echo '${element(aws_instance.cZServers.*.public_ip, count.index)}' >> hosts1"
}
}
