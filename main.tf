terraform {
  required_providers {
    criblio = {
      source  = "criblio/criblio"
      version = "1.20.135"
    }
  }
}

provider "criblio" {
  # Credentials will be read from environment variables
}