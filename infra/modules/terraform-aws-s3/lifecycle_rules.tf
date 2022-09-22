
variable "region_download_s3_lifecycle_rules" {
  description = "Map of platform download S3 lifecycle rules"
  type        = list(map(any))
  default = [
    {
        id      = "all"
        enabled = true
        prefix = ""
        # apply_lifecycle_rule = "yes"
        expiration_days = 7
        expired_object_delete_marker = "true"
        noncurrent_version_expiration_days = 7
    }
]
}



