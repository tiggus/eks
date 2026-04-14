# resource "aws_lambda_function" "aurora" {
#   architectures                      = ["x86_64"]
#   code_signing_config_arn            = null
#   description                        = "Rotates a Secrets Manager secret for Amazon RDS PostgreSQL credentials using the single user rotation strategy."
#   filename                           = null
#   function_name                      = "aurora-rotation-${random_id.random.hex}"
#   handler                            = "lambda_function.lambda_handler"
#   image_uri                          = null
#   kms_key_arn                        = null
#   layers                             = []
#   memory_size                        = 128
#   package_type                       = "Zip"
#   publish                            = null
#   replace_security_groups_on_destroy = null
#   replacement_security_group_ids     = null
#   reserved_concurrent_executions     = -1
#   role                               = aws_iam_role.aurora.arn
#   runtime                            = "python3.10"
#   s3_bucket                          = null
#   s3_key                             = null
#   s3_object_version                  = null
#   skip_destroy                       = false
#   source_code_hash                   = null
#   tags = {
#     SecretsManagerLambda = "Rotation"
#     "lambda:createdBy"   = "SAM"
#   }
#   tags_all = {
#     SecretsManagerLambda = "Rotation"
#     "lambda:createdBy"   = "SAM"
#   }
#   timeout = 30
#   environment {
#     variables = {
#       EXCLUDE_CHARACTERS         = ":/@\"'\\"
#       EXCLUDE_LOWERCASE          = "false"
#       EXCLUDE_NUMBERS            = "false"
#       EXCLUDE_PUNCTUATION        = "false"
#       EXCLUDE_UPPERCASE          = "false"
#       PASSWORD_LENGTH            = "32"
#       REQUIRE_EACH_INCLUDED_TYPE = "true"
#       SECRETS_MANAGER_ENDPOINT   = "https://secretsmanager.us-east-1.amazonaws.com"
#     }
#   }
#   ephemeral_storage {
#     size = 512
#   }
#   logging_config {
#     application_log_level = null
#     log_format            = "Text"
#     log_group             = "/aws/lambda/aurora-rotation"
#     system_log_level      = null
#   }
#   tracing_config {
#     mode = "PassThrough"
#   }
#   vpc_config {
#     ipv6_allowed_for_dual_stack = false
#     security_group_ids          = ["sg-0c6e7b23da2e0d4ee"]
#     subnet_ids                  = ["subnet-00984979dc29c8cd3", "subnet-014145a11cf901be6", "subnet-036ce297fdc4f87a2", "subnet-06ff855a09d56f528", "subnet-0874befd78b3941f0", "subnet-0d57e4dc31337fb92"]
#   }
# }