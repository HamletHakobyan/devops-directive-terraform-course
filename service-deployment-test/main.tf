resource "aws_elastic_beanstalk_application" "nc" {
  name        = "notification-center-app"
  description = "Notification center application"

  appversion_lifecycle {
    max_count = 2
    delete_source_from_s3 = true
    service_role = aws_iam_role.eb_service_role.name
  }
}

data "aws_availability_zones" "region_zones" {
  
}


module "elastic-beanstalk-application" {
  source  = "cloudposse/elastic-beanstalk-application/aws"
  version = "0.12.0"

  name        = "notification-center-app"
  description = "Notification center application"

  appversion_lifecycle_delete_source_from_s3 = true
  appversion_lifecycle_max_count = 2
  appversion_lifecycle_service_role_arn = aws_iam_role.eb_service_role

  prefer_legacy_service_policy = false

  environment = var.environment

  enabled = true
}


# module "elastic-beanstalk-environment" {
#   source  = "cloudposse/elastic-beanstalk-environment/aws"
#   version = "0.51.2"
#   # insert the 5 required variables here
# }