variable "resource_group_name" {
  description = "Resource Group name"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "vnet_name" {
  description = "Virtual Network name"
  type        = string
}

variable "address_space" {
  description = "VNet address space"
  type        = list(string)
}

variable "subnets" {
  description = "Subnets configuration"

  type = map(object({
    address_prefix = string
  }))
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}