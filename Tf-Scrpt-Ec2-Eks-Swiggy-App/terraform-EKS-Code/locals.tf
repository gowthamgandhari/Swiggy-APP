locals {
  name            = "Swiggy-cluster"
  region          = "ap-south-1"
  vpc_cidr        = "19.20.0.0/16"
  azs             = ["ap-south-1a", "ap-south-1b"]
  public_subnets  = ["19.20.40.0/24", "19.20.60.0/24"]
  private_subnets = ["19.20.70.0/24", "19.20.90.0/24"]
  intra_subnets   = ["19.20.1.0/24", "19.20.2.0/24"]
}

locals {
  tags = {
    Example = local.name
  }
}
