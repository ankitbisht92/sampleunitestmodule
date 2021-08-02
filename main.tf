terraform {
  required_providers {
      azurerm = {
          source = "hashicorp/azurerm"
          version = ">=2.44.0"
      }
  }
}

provider "azurerm"{
   features {}
}

locals{
  endpoints = {
     endpoint = {
      name = var.endpoint_name[0]
      origin = [{
        origin_name = var.origin_name[0],
        origin_host_name = var.origin_host_name[0],
        http_port = var.http_port[0],
        https_port = var.https_port[0]
      }
      ]
    }
    endpoint_2 = {
      name = var.endpoint_name[1]
      origin = [{
        origin_name = var.origin_name[1],
        origin_host_name = var.origin_host_name[1],
        http_port = var.http_port[1],
        https_port = var.https_port[1]
      }
      ]
    }
  }
}

data "azurerm_resource_group" "resource_group" {
  name     = var.resource_group_name
}
#Creates a CDN profile for CDN resource
resource "azurerm_cdn_profile" "cdn_profile"{
    name                = var.cdn_profile_name
    location            = data.azurerm_resource_group.resource_group.location
    resource_group_name = data.azurerm_resource_group.resource_group.name
    sku                 = var.sku
}

#Creates a CDN endpoint for CDN resource
resource "azurerm_cdn_endpoint" "cdn_endpoint"{
    for_each = local.endpoints
    name                = each.value.name
    profile_name        = azurerm_cdn_profile.cdn_profile.name
    location            = data.azurerm_resource_group.resource_group.location
    resource_group_name = data.azurerm_resource_group.resource_group.name

  #this would setup origin for the cdn endpoint
    dynamic "origin" {
      for_each = each.value.origin
      content{
      name        = origin.value.origin_name
      host_name   = origin.value.origin_host_name
      http_port   = origin.value.http_port
      https_port  = origin.value.https_port
    }
    }
  #this would allow particular path within the origin to a particular country
  /*
  geo_filter{
        relative_path     = var.relative_path
        action            = var.action
        country_codes     = var.country_codes
  }
  #this would provision caching rules for the endpoint
  delivery_rule{
        name              = var.rule_name
        order             = var.order
        cache_expiration_action{
        behavior          = var.expiration_action_behavior
        }
        cache_key_query_string_action{
        behavior          = var.string_action_behavior
        }
        modify_request_header_action{
        
        }
  }*/
}