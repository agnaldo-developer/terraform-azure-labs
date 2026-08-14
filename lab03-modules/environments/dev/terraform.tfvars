location    = "brazilsouth"
environment = "dev"

address_space = [
  "10.30.0.0/16"
]

subnets = {
  web = {
    address_prefix = "10.30.1.0/24"
  }

  app = {
    address_prefix = "10.30.2.0/24"
  }

  db = {
    address_prefix = "10.30.3.0/24"
  }
}