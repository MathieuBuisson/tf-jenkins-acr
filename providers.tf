provider "azurerm" {
  # Preventing automatic upgrades to new versions that may contain breaking changes.
  # Any non-beta version >= 1.25.0 and < 2.0.0
  version = "~>1.25"
}

provider "random" {
  version = "~>2.1"
}

terraform {
  required_version = ">= 0.11.13"
}
