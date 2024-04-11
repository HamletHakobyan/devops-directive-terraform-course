data "aws_iam_policy_document" "service_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["elasticbeanstalk.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["elasticbeanstalk"]
    }
  }
}

resource "aws_iam_role" "eb_service_role" {
  name               = "nc_eb_required_service_role"
  assume_role_policy = data.aws_iam_policy_document.service_assume_role.json
}

resource "aws_iam_role_policy_attachment" "eb_service_required_01_attach" {
  role       = aws_iam_role.eb_service_role.name
  policy_arn = data.aws_iam_policy.eb_service_required_01.arn
}

resource "aws_iam_role_policy_attachment" "eb_service_required_02_attach" {
  role       = aws_iam_role.eb_service_role.name
  policy_arn = data.aws_iam_policy.eb_service_required_02.arn
}

data "aws_iam_policy" "eb_service_required_01" {
  name = "AWSElasticBeanstalkEnhancedHealth"
}

data "aws_iam_policy" "eb_service_required_02" {
  name = "AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy"
}