# terraform-azure-tags

Org-standard tag module. Enforces a mandatory tag schema on every resource it's applied to and merges in any extra, team-specific tags — so "enforce standard tagging" is one `module` call instead of a convention teams have to remember.

This module has no dependency on Azure Verified Modules (AVM doesn't ship a tagging module); it's pure Terraform logic and requires no provider or Azure credentials to plan.

## Usage

```hcl
module "tags" {
  source  = "git::https://github.com/engryinker/terraform-azure-tags.git?ref=v1.0.0"

  environment = "prod"
  owner       = "platform-team@contoso.com"
  cost_center = "CC-1234"
  application = "app1"

  additional_tags = {
    data_classification = "internal"
  }
}

resource "azurerm_resource_group" "this" {
  name     = "rg-app1-prod-eus"
  location = "eastus"
  tags     = module.tags.tags
}
```

Compose with [`terraform-azure-naming`](https://github.com/engryinker/terraform-azure-naming) and pass `module.tags.tags` into any of [`terraform-azure-network`](https://github.com/engryinker/terraform-azure-network), [`terraform-azure-compute`](https://github.com/engryinker/terraform-azure-compute) or [`terraform-azure-storage`](https://github.com/engryinker/terraform-azure-storage) via their `tags` input.

See [`examples/basic`](examples/basic) for a runnable example.

## Inputs

| Name              | Type         | Default      | Required | Description                                                        |
| ----------------- | ------------ | ------------ | :------: | ------------------------------------------------------------------- |
| `environment`     | string       | —            |    yes   | One of `dev`, `test`, `stage`, `prod`, `sandbox`.                   |
| `owner`           | string       | —            |    yes   | Email or team accountable for the resource.                         |
| `cost_center`     | string       | —            |    yes   | Billing / cost allocation code.                                     |
| `application`     | string       | —            |    yes   | Application or workload name.                                       |
| `managed_by`      | string       | `"Terraform"`|    no    | Tooling that manages the resource's lifecycle.                      |
| `additional_tags` | map(string)  | `{}`         |    no    | Extra tags merged in; cannot override the five mandatory keys above.|

## Outputs

| Name   | Description                                           |
| ------ | ------------------------------------------------------ |
| `tags` | Final merged tag map ready to pass to `tags = ...` on any `azurerm_*` resource or AVM module call. |
