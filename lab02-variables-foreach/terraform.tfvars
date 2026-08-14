location    = "brazilsouth"
environment = "dev"

vnet_address_space = [
  "10.20.0.0/16"
]

subnets = {
  web = {
    address_prefix = "10.20.1.0/24"
  }

  db = {
    address_prefix = "10.20.3.0/24"
  }

  management = {
    address_prefix = "10.20.4.0/24"
  }
}