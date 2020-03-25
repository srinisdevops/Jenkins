variable "region" {
default = "us-east-2"
}
variable "amiid" {
  type = "map"
  default = {
    us-east-2 = "ami-0fc20dd1da406780b"
    us-east-1 = "ami-0400a1104d5b9caa1"
    us-west-1 = "ami-03ba3948f6c37a4b0"
  }
  description = "You may added more regions if you want"
}

variable "instance_count" {
  default = "1"
}
variable "key_name" {
  default = "MyKeyPair"
  description = "the ssh key to be used for the EC2 instance"
}


variable "security_group" {
  default     = "sg-06b2e5950e8c41e0d"
  description = "Security groups for the instance"
}

