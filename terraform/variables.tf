variable "project_name" {
  default = "task5"
}

variable "aws_region" {
  default = "us-west-1"
}

variable "cluster_name" {
  default = "task5-eks"
}

variable "db_name" {}

variable "db_username" {}

variable "db_password" {
  sensitive = true
}

variable "sender_email" {}

variable "receiver_email" {}