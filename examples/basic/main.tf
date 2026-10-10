terraform {
  required_version = ">= 1.7.0"
}

module "tags" {
  source = "../.."

  environment = "prod"
  owner       = "platform-team@contoso.com"
  cost_center = "CC-1234"
  application = "app1"

  additional_tags = {
    data_classification = "internal"
  }
}

output "tags" {
  value = module.tags.tags
}
