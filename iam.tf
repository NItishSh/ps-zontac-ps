resource "aws_iam_user" "wbs_restart" {
  name = "wbs-restart"
  path = "/system/"

  tags = {
    tag-key = "tag-value"
  }
}

resource "aws_iam_policy" "wbs_restart" {
  name        = "wbs-restart-instances"
  description = ""
  policy      = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "ec2:RebootInstances"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF
}

resource "aws_iam_user_policy_attachment" "wbs_restart_attach" {
  user       = aws_iam_user.wbs_restart.name
  policy_arn = aws_iam_policy.wbs_restart.arn
}
