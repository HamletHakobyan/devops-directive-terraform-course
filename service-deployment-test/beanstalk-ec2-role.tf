data "aws_iam_policy_document" "ec2_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]

    condition {
      test     = "StringEquals"
      variable = "sts:ExternalId"
      values   = ["ec2"]
    }
  }
}

resource "aws_iam_role" "eb_ec2_role" {
  name               = "nc_eb_required_ec2_role"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role.json
}

resource "aws_iam_role_policy_attachment" "eb_ec2_required_01_attach" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = data.aws_iam_policy.eb_ec2_required_01.arn
}

resource "aws_iam_role_policy_attachment" "eb_ec2_required_02_attach" {
  role       = aws_iam_role.eb_ec2_role.name
  policy_arn = data.aws_iam_policy.eb_ec2_required_02.arn
}

data "aws_iam_policy" "eb_ec2_required_01" {
  name = "AmazonEC2ContainerRegistryReadOnly"
}

data "aws_iam_policy" "eb_ec2_required_02" {
  name = "AWSElasticBeanstalkWebTier"
}