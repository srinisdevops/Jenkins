provider "aws" {
  region = "us-east-2"
}

terraform {
  backend "s3" {
    bucket = "mybucket02222020"

    #key    = "tfstatefiles/terraform.tfstate"
    key    = "jenkins/04/terraform.tfstate"
    region = "us-east-2"
  }
}

resource "aws_instance" "srini_servers" {
  #ami = "ami-0fc20dd1da406780b"
  ami                    = lookup(var.amiid, var.region)
  count                  = var.instance_count
  instance_type          = "t2.micro"
  vpc_security_group_ids = [var.security_group]
  key_name               = var.key_name
  tags = {
    #Name = "tf-example"
    Name = "tf-docker-${count.index + 1}"
  }
  #allow_userdata = true
  user_data = file("user-data.txt")
}

output "public_ip" {
  value = "${formatlist("%v",aws_instance.srini_servers.*.public_ip)}"
}

resource "null_resource" "myPublicIps" {
count = var.instance_count
provisioner "local-exec" {
      command = "echo '${element(aws_instance.srini_servers.*.public_ip, count.index)}' >> hosts1"
}
}


output "user_data" {
  value = aws_instance.srini_servers.*.user_data
}

