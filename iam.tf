data "aws_iam_policy_document" "bastion" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "bastion" {
  name               = "bastion"
  assume_role_policy = data.aws_iam_policy_document.bastion.json
}

resource "aws_iam_role_policy_attachment" "bastion" {
  role       = aws_iam_role.bastion.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "bastion" {
  name = "bastion"
  role = aws_iam_role.bastion.name
}






# # variable "bastion_host_policy" {
# #   type = object({
# #     managed_policy_arns = list(string)
# #     inline_policy       = map(any)
# #   })
# # }




# # resource "aws_iam_role" "nodes" {
# #   name = "${module.aws-eks.cluster_name}-node"

# #   assume_role_policy = jsonencode({
# #     Statement = [{
# #       Action = "sts:AssumeRole"
# #       Effect = "Allow"
# #       Principal = {
# #         Service = "ec2.amazonaws.com"
# #       }
# #     }]
# #     Version = "2012-10-17"
# #   })
# # }

# # resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
# #   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
# #   role       = aws_iam_role.nodes.name
# # }

# # resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
# #   policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
# #   role       = aws_iam_role.nodes.name
# # }

# # resource "aws_iam_role_policy_attachment" "eks_container_registry_policy" {
# #   policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
# #   role       = aws_iam_role.nodes.name
# # }






# # resource "aws_iam_role" "aurora" {
# #   assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"lambda.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
# #   description           = null
# #   force_detach_policies = false
# #   max_session_duration  = 3600
# #   name                  = "rds-postgres-${random_id.random.hex}"
# #   name_prefix           = null
# #   path                  = "/"
# #   permissions_boundary  = null
# #   tags = {
# #     SecretsManagerLambda = "Rotation"
# #     "lambda:createdBy"   = "SAM"
# #   }
# #   tags_all = {
# #     SecretsManagerLambda = "Rotation"
# #     "lambda:createdBy"   = "SAM"
# #   }
# # }

# # data "aws_iam_policy_document" "lambda_assum_role_policy"{
# #   statement {
# #     effect  = "Allow"
# #     actions = ["sts:AssumeRole"]
# #     principals {
# #       type        = "Service"
# #       identifiers = ["lambda.amazonaws.com"]
# #     }
# #   }
# # }

# # resource "aws_iam_role" "lambda_role" {  
# #   name = "lambda-lambdaRole-waf"  
# #   assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
# # }