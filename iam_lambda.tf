# Iam permissions for lambda verification
resource "aws_iam_role" "role_for_lambda" {
  name               = join("-", [ local.name,"role"])
  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
  tags               = local.tags
}

# # Iam permissions for lambda payment
# resource "aws_iam_role" "role_for_lambda_payment" {
#   name               = join("-", [ local.name,"role"])
#   assume_role_policy = <<EOF
# {
#   "Version": "2012-10-17",
#   "Statement": [
#     {
#       "Action": "sts:AssumeRole",
#       "Principal": {
#         "Service": "lambda.amazonaws.com"
#       },
#       "Effect": "Allow",
#       "Sid": ""
#     }
#   ]
# }
# EOF
#   tags               = local.tags
# }

resource "aws_iam_policy_attachment" "test-attach" {
  name       = "test-attachment"
  roles      = [ aws_iam_role.role_for_lambda.name]
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}


# resource "aws_iam_policy" "moncash _secret_access" {
#   name        = join("-", [ local.name,"moncash-secret-access-policy"])
#   path        = "/"
#   description = "policy for moncash payment lambda with dynamo permissions"

#   policy = <<-EOF
#   {
#     "Version": "2012-10-17",
#     "Statement": [
#         {
#             "Sid": "permission",
#             "Effect": "Allow",
#             "Action": [
#                 "secretsmanager:GetSecretValue"
#             ],
#             "Resource": [
#                 "${aws_secretsmanager_secret.onboarding_verification.arn}"
#             ]
#         }
#     ]
#   }
#   EOF
# }

# resource "aws_iam_policy_attachment" "attach_policy_dynamo" {
#   name       = "policy-attachment-to-lambda-role2"
#   roles      = [aws_iam_role.role_for_lambda.name]
#   policy_arn = aws_iam_policy.dynamo.arn
# }

