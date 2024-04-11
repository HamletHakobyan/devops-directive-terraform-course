
module "vpc" {
  source = "cloudposse/vpc/aws"
  version = "2.1.1"

  name = data.aws_availability_zones.region_zones.id

}

data "aws_availability_zones" "zones" {
  state = "available"
}

