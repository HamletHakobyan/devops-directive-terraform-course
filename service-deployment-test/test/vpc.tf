
module "vpc" {
  source = "cloudposse/vpc/aws"
  version = "2.1.1"

  name = "nc_vpc"
  ipv4_primary_cidr_block = "10.0.0.0/16"

  assign_generated_ipv6_cidr_block = true
  namespace = "nc_vpc_ns"
  stage = "test"
}

module "subnets" {
  source = "cloudposse/dynamic-subnets/aws"
  version= "2.4.2"

  vpc_id = module.vpc.vpc_id

  availability_zone_ids = random_shuffle.az_subset.result
  namespace = "nc_vpc_subnets"
  stage = "test"
}

data "aws_availability_zones" "zones" {
  state = "available"
}

resource "random_shuffle" "az_subset" {
  input = data.aws_availability_zones.zones.zone_ids
  result_count = 2
}

output "region_zones" {
  value = data.aws_availability_zones.zones
}