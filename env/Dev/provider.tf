terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.60.0"
    }
  }
}

provider "azurerm" {
  features        {
   key_vault {
      purge_soft_delete_on_destroy    = true
    }
  }
  subscription_id = "89ea6cde-b718-4376-9ae5-97e5654340e8"
}