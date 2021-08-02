variable "resource_group_name" {
    type = string
    description = "Existing resource group name"
}

/*variable "az_region"{
    type = string
    description = "Existing region name"
}*/

variable "cdn_profile_name"{
    type = string
    description = "CDN Profile Name"
}

variable "sku"{
    type = string
    description = "sku name for CDN Profile"
}

/*variable "cdn_endpoint_name"{
    type = string
    description = "CDN Endpoint Name"
}

variable "origin_name" {
    type = string
    description = "Origin Name"
}

variable "origin_host_name" {
    type = string
    description = "Origin Host Name"
}*/

variable "endpoint_name" {
    type = list(string)
    description = "endpoit names"
    default = ["endpoint-one","endpoint-two"]
}

variable "origin_name" {
    type = list(string)
    description = "origin names"
    default = ["origin-one","origin-two"]
}

variable "origin_host_name"{
    type = list(string)
    description = "origin host names"
    default = ["www.google.com","www.facebook.com"]
}

variable "http_port" {
    type = list(string)
    description = "http port"
    default = [ "80","80" ]
}

variable "https_port" {
    type = list(string)
    description = "https port"
    default = [ "443","443" ]
  
}