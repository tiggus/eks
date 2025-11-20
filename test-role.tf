
# resource "aws_iam_role" "medi" {
#   assume_role_policy    = "{\"Statement\":[{\"Action\":\"sts:AssumeRole\",\"Effect\":\"Allow\",\"Principal\":{\"Service\":\"ec2.amazonaws.com\"}}],\"Version\":\"2012-10-17\"}"
#   description           = "Allows EC2 instances to call AWS services on your behalf."
#   force_detach_policies = false
#   max_session_duration  = 3600
#   name                  = "import-test"
#   name_prefix           = null
#   path                  = "/"
#   permissions_boundary  = null
#   tags                  = {}
#   tags_all              = {}
# }
