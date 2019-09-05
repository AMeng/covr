provider "aws" {
  version = "2.25.0"
}

terraform {
  required_version = "0.11.14"

  backend "local" {
    path = "covr.tfstate"
  }
}

provider "kubernetes" {
  config_context_cluster = "covr.k8s.local"
}
