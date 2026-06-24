variable "project_name" {
  default = "task5"
}

variable "aws_region" {
  default = "us-west-1"
}

variable "cluster_name" {
  default = "task5-eks"
}

variable "db_name" {
  type = string
}

variable "db_username" {
  type = string
}

variable "db_password" {
  type      = string
  sensitive = true
}

variable "sender_email" {
  type = string
}

variable "receiver_email" {
  type = string
}