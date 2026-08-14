variable "location" {
  description = "Azure region"
  type        = string
}

variable "environment" {
  description = "Environment name"
  type        = string
}

variable "vnet_address_space" {
  description = "Address space of the VNet"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets to be created"

  type = map(object({
    address_prefix = string
  }))
}