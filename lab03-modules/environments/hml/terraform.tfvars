location    = "brazilsouth"
environment = "hml"

address_space = [
  "10.40.0.0/16"
]

subnets = {
  web = {
    address_prefix = "10.40.1.0/24"
  }

  app = {
    address_prefix = "10.40.2.0/24"
  }

  db = {
    address_prefix = "10.40.3.0/24"
  }
}