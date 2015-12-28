variable "project" {
  default = "exampleapp"
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "ap-northeast-1"
}

variable "availability_zones" {
  default = "ap-northeast-1a,ap-northeast-1c"
}

variable "ami" {
  default = "ami-936d9d93" # Ubuntu Server 14.04 LTS (HVM), SSD Volume Type
}

variable "s3_bucket_name" {
  default = "exampleapp"
}

variable "ec2_public_key" {}
variable "ec2_stage" {
  default = "production"
}
