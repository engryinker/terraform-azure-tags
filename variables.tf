variable "environment" {
  description = "Deployment environment. Must be one of: dev, test, stage, prod, sandbox."
  type        = string

  validation {
    condition     = contains(["dev", "test", "stage", "prod", "sandbox"], var.environment)
    error_message = "environment must be one of: dev, test, stage, prod, sandbox."
  }
}

variable "owner" {
  description = "Email address or team name accountable for the resources carrying this tag set."
  type        = string

  validation {
    condition     = length(trimspace(var.owner)) > 0
    error_message = "owner must not be empty."
  }
}

variable "cost_center" {
  description = "Cost center / billing code to allocate spend for these resources."
  type        = string

  validation {
    condition     = length(trimspace(var.cost_center)) > 0
    error_message = "cost_center must not be empty."
  }
}

variable "application" {
  description = "Name of the application or workload these resources belong to."
  type        = string

  validation {
    condition     = length(trimspace(var.application)) > 0
    error_message = "application must not be empty."
  }
}

variable "managed_by" {
  description = "Tooling that manages this resource's lifecycle."
  type        = string
  default     = "Terraform"
}

variable "additional_tags" {
  description = "Extra tags to merge on top of the mandatory tag set. Keys here never override the mandatory keys (environment, owner, cost_center, application, managed_by) — those are always enforced by this module."
  type        = map(string)
  default     = {}
}
