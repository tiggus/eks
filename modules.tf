module "aurora" {
  source = "./modules/aurora"
}

# module "aurora-two" {
#   source = "./modules/aurora"
# }

module "aws-eks" {
  account_id          = data.aws_caller_identity.current.account_id
  authentication_mode = "API"
  cluster_root        = var.cluster_root
  create_cluster      = true
  cluster_version     = "1.34"
  # providers = {
  #   aws = aws.eu-west-2
  # }
  source             = "./modules/aws-eks"
  private_subnet_ids = module.aws-vpc.private_subnet_ids
  #  depends_on         = [module.aws-vpc]

  # eks_managed_node_groups = {
  #   one = {
  #     name = "node-group-1"

  #     instance_types = ["t3.small"]

  #     min_size     = 1
  #     max_size     = 3
  #     desired_size = 2
  #   }

  #   two = {
  #     name = "node-group-2"

  #     instance_types = ["t3.small"]

  #     min_size     = 1
  #     max_size     = 2
  #     desired_size = 1
  #   }
  # }
}



module "aws-vpc" {
  create_vpc             = true
  create_public_subnets  = true
  create_private_subnets = true
  create_igw             = true
  enable_dns_hostnames   = true
  enable_nat_gateway     = true
  enable_dns_support     = true
  ip_cidr_range          = var.ip_cidr_range
  ip_private_subnets     = var.ip_private_subnets
  ip_public_subnets      = var.ip_public_subnets
  manage_security_group  = true
  manage_nacl            = true
  manage_route_table     = true
  # providers = {
  #   aws = aws.eu-west-2
  # }
  source             = "./modules/aws-vpc"
  single_nat_gateway = true
}
