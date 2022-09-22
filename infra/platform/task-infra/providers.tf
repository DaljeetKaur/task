//Deployment Region
provider "aws" {
  region  = var.region
}

//AWS certificate Manager Region
provider "aws" {
  region = "us-east-1"
  alias = "use1"
}
