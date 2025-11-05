locals {
  name            = "Swiggy-cluster2"
  region          = "ap-south-1"
  vpc_cidr        = "19.30.0.0/16"
  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["19.30.40.0/24", "19.30.60.0/24"]
  private_subnets = ["19.30.70.0/24", "19.30.90.0/24"]
  intra_subnets   = ["19.30.1.0/24", "19.30.2.0/24"]
}

locals {
  tags = {
    Example = local.name
  }
}
