resource "aws_iam_role" "github" {
  assume_role_policy = jsonencode({
    Statement = [{
      Action = "sts:AssumeRoleWithWebIdentity"
      Condition = {
        StringEquals = {
          "token.actions.githubusercontent.com:aud" = "sts.amazonaws.com"
        }
        StringLike = {
          "token.actions.githubusercontent.com:sub" = ["repo:tiggus/eks:*"]
        }
      }
      Effect = "Allow"
      Principal = {
        Federated = "arn:aws:iam::791860731874:oidc-provider/token.actions.githubusercontent.com"
      }
    }]
    Version = "2012-10-17"
  })
  description           = null
  force_detach_policies = false
  max_session_duration  = 3600
  name                  = "github-oidc"
  name_prefix           = null
  path                  = "/"
  permissions_boundary  = null
  tags                  = {}
  tags_all              = {}
}

resource "aws_iam_role_policy_attachment" "github" {
  role       = aws_iam_role.github.name
  policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}
