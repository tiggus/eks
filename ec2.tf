###############################################################
# bastion
###############################################################
resource "aws_instance" "bastion" {
  ami                         = "ami-098e39bafa7e7303d" #= data.aws_ami.al2023.id
  instance_type               = "t3.micro"
  subnet_id                   = module.aws-vpc.private_subnet_ids[0]
  associate_public_ip_address = false
  #iam_instance_profile        = aws_iam_instance_profile.bastion.name
  vpc_security_group_ids = [aws_security_group.bastion.id]

  root_block_device {
    encrypted = true
  }

  metadata_options {
    http_endpoint = "enabled"
    http_tokens   = "required"
  }

  tags = {
    Name = "bastion"
  }

}


resource "aws_security_group" "bastion" {
  name        = "bastion"
  description = "allow ssm"
  vpc_id      = module.aws-vpc.vpc.id
  tags = {
    Name = "bastion"
  }
}

# resource "aws_vpc_security_group_egress_rule" "https" {
#   security_group_id = aws_security_group.bastion.id

#   cidr_ipv4   = "10.0.0.0/16"
#   from_port   = 443
#   ip_protocol = "tcp"
#   to_port     = 443
#   tags = {
#     Name = "bastion"
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "https" {
#   security_group_id = aws_security_group.bastion.id

#   cidr_ipv4   = "10.0.0.0/16"
#   from_port   = 443
#   ip_protocol = "tcp"
#   to_port     = 443
#   tags = {
#     Name = "bastion"
#   }
# }

resource "aws_vpc_security_group_egress_rule" "all" {
  security_group_id = aws_security_group.bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = -1
  ip_protocol = "tcp"
  to_port     = -1
  tags = {
    Name = "all"
  }
}

resource "aws_vpc_security_group_ingress_rule" "ssh" {
  security_group_id = aws_security_group.bastion.id

  cidr_ipv4   = "0.0.0.0/0"
  from_port   = 22
  ip_protocol = "tcp"
  to_port     = 22
  tags = {
    Name = "ssh"
  }
}

# resource "aws_vpc_endpoint" "ec2" {
#   vpc_id             = module.aws-vpc.vpc.id
#   service_name       = "com.amazonaws.us-east-1.ec2messages"
#   vpc_endpoint_type  = "Interface"
#   subnet_ids         = module.aws-vpc.private_subnet_ids
#   security_group_ids = [aws_security_group.bastion.id]
# }

# resource "aws_vpc_endpoint" "ssm" {
#   vpc_id             = module.aws-vpc.vpc.id
#   service_name       = "com.amazonaws.us-east-1.ssm"
#   vpc_endpoint_type  = "Interface"
#   subnet_ids         = module.aws-vpc.private_subnet_ids
#   security_group_ids = [aws_security_group.bastion.id]
# }

# resource "aws_vpc_endpoint" "ssmmessages" {
#   vpc_id             = module.aws-vpc.vpc.id
#   service_name       = "com.amazonaws.us-east-1.ssmmessages"
#   vpc_endpoint_type  = "Interface"
#   subnet_ids         = module.aws-vpc.private_subnet_ids
#   security_group_ids = [aws_security_group.bastion.id]
# }




# # data "aws_ssm_parameter" "eks_ami" {
# #   #name = "/aws/service/bottlerocket/aws-k8s-${module.aws-eks.cluster_version}/x86_64/latest/image_id" 
# #   name = "/aws/service/eks/optimized-ami/${module.aws-eks.cluster_version}/amazon-linux-2023/x86_64/standard/recommended/image_id" #"/aws/service/eks/optimized-ami/${module.aws-eks.cluster_version}/amazon-linux-2023/x86_64/standard/recommended/release_version"
# # }                                                                                                                                  #name = "/aws/service/eks/optimized-ami/${aws_eks_cluster.eks_cluster.version}/amazon-linux-2/recommended/image_id"


# # resource "aws_launch_template" "eks_nodes" {
# #   name                   = "${module.aws-eks.cluster_name}-node-template"
# #   instance_type          = "t3.micro"
# #   image_id               = data.aws_ssm_parameter.eks_ami.value
# #   vpc_security_group_ids = [module.aws-eks.cluster_security_group_id]

# #   user_data = base64encode(<<-EOF
# #     #!/bin/bash
# #     set -o xtrace
# #     /etc/eks/bootstrap.sh ${module.aws-eks.cluster_name}
# #   EOF
# #   )

# #   tag_specifications {
# #     resource_type = "instance"
# #     tags = {
# #       Name = "${module.aws-eks.cluster_name}-node"
# #     }
# #   }
# # }

# # data "aws_ssm_parameter" "eks_ami_release_version" {
# #   name = "/aws/service/bottlerocket/aws-k8s-${module.aws-eks.cluster_version}/x86_64/latest/image_id" #"/aws/service/eks/optimized-ami/${module.aws-eks.cluster_version}/amazon-linux-2023/x86_64/standard/recommended/release_version"
# # }

# # resource "aws_autoscaling_group" "eks_nodes" {
# #   name                = "${module.aws-eks.cluster_name}-nodes"
# #   desired_capacity    = 1
# #   max_size            = 2
# #   min_size            = 0
# #   target_group_arns   = []
# #   vpc_zone_identifier = module.aws-vpc.private_subnet_ids # module.aws-eks.private_subnet_ids[*].id #aws_subnet.eks_subnets[*].id

# #   launch_template {
# #     id      = aws_launch_template.eks_nodes.id
# #     version = "$Latest"
# #   }

# #   tag {
# #     key                 = "kubernetes.io/cluster/${module.aws-eks.cluster_name}"
# #     value               = "owned"
# #     propagate_at_launch = true
# #   }
# # }









# # resource "aws_eks_node_group" "example" {
# #   cluster_name    = module.aws-eks.cluster_name
# #   node_group_name = "example"
# #   version         = aws_eks_cluster.example.version
# #   release_version = nonsensitive(data.aws_ssm_parameter.eks_ami_release_version.value)
# #   node_role_arn   = aws_iam_role.example.arn
# #   subnet_ids      = aws_subnet.example[*].id
# # }