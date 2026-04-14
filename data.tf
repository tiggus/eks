data "aws_caller_identity" "current" {}

data "aws_ami" "al2023" {
  most_recent = true
  owners      = ["amazon"]

  #   filter {
  #     name   = "name"
  #     values = ["al2023-ami-2023.*-x86_64"]
  #   }
  filter {
    name   = "name"
    values = ["al2023-ami*.*-x86_64"] #al2023-ami-2023.11.20260413.0-kernel-6.1-x86_64
  }


  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

data "aws_ami" "ubuntu2404" {
  most_recent = true
  owners      = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }
}

output "amazon_linux" {
  value = data.aws_ami.al2023.image_id
}

output "ubuntu" {
  value = data.aws_ami.ubuntu2404.image_id
}


# data "aws_ami" "linux2023" {
#   #executable_users = ["self"]
#   most_recent = true
#   name_regex  = "^al2023-ami-kernel"
#   owners      = ["amazon"]

#   #   filter {
#   #     name   = "name"
#   #     values = ["myami-*"]
#   #   }
#   filter {
#     name   = "architecture"
#     values = ["x86_64"]
#   }

#   #   filter {
#   #     name   = "root-device-type"
#   #     values = ["ebs"]
#   #   }

#   #   filter {
#   #     name   = "virtualization-type"
#   #     values = ["hvm"]
#   #   }
# }