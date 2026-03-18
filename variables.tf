variable "terraform_bucket" {
  type    = string
  default = "terraform-test"
}

variable "secure_bucket" {
  type    = string
  default = "secure-test"
}

variable "cluster_root" {
  type    = string
  default = "eks-cluster"
}

variable "vpc_root" {
  type    = string
  default = "eks-vpc"
}

variable "ip_cidr_range" {
  type    = string
  default = "10.0.0.0/16"
}

variable "ip_private_subnets" {
  default = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  type    = set(string)
}

variable "ip_public_subnets" {
  default = ["10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24"]
  type    = set(string)
}

