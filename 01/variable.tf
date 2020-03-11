variable "region" {
  default = "us-east-2"
}


variable "amiid" {
  type = map
  default = {
    us-east-2 = "ami-0fc20dd1da406780b"
    us-east-1 = "ami-759bc50a"
    eu-west-1 = "ami-4aa04129"
  }
  description = "You may added more regions if you want"
}

variable "instance_count" {
  default = "1"
}
variable "key_name" {
  default = "MyKeyPair"
  description = "the ssh key to used for the EC2 instance"
}

variable "security_group" {
  default = "sg-06b2e5950e8c41e0d"
  description = "Security groups for the instance"
}



