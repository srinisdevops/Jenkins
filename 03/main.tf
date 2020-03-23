provider "aws" {
  region = "us-east-2"
}

#terraform {
#  backend "s3" {
#    bucket = "mybucket02222020"
#
#    #key    = "tfstatefiles/terraform.tfstate"
#    key    = "jenkins/02/terraform.tfstate"
#    region = "us-east-2"
#  }
#}

resource "aws_instance" "srini_servers" {
  #ami = "ami-0fc20dd1da406780b"
  ami                    = lookup(var.amiid, var.region)
  count                  = var.instance_count
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.security_group]
  key_name               = var.key_name
  root_block_device {
    volume_size = 12
  }
  tags = {
    #Name = "tf-example"
    Name = "tf-jenkins-${count.index + 1}"
  }
  #allow_userdata = true
  user_data = file("user-data.sh")
}

output "public_ip" {
  value = aws_instance.srini_servers.*.public_ip
}

output "user_data" {
  value = aws_instance.srini_servers.*.user_data
}

