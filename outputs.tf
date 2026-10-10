output "tags" {
  description = "Final merged tag map: mandatory org tags plus any additional_tags, with mandatory keys always taking precedence."
  value       = local.tags
}
