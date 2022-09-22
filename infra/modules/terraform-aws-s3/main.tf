locals {

	download_bucket_name = ["region-download-s3"]

    region_name = split("-",var.region)
    region_short_name = format("%s%s%s", local.region_name[0] ,substr(local.region_name[1], 0, 1),substr(local.region_name[2], 0, 1))
    bucket_suffix_name = format("%s%s","-",local.region_short_name)

}


resource "aws_s3_bucket" "region_download_s3_bucket" {
    count = var.create_download_bucket ? 1 : 0
    bucket_prefix = "s3bucket"
   // bucket = format("%s%s%s",var.proj_s3_name_prefix,local.proj_bucket_names[count.index], local.bucket_suffix_name )
    acl = var.acl
    policy = var.policy
    force_destroy = var.force_destroy
    tags = var.tags

    dynamic "lifecycle_rule" {
    for_each = var.region_download_s3_lifecycle_rules
    content {
      id      = lookup(lifecycle_rule.value, "id", null)
      enabled = lookup(lifecycle_rule.value, "enabled", null)
      prefix  = lookup(lifecycle_rule.value, "prefix", null)
      tags = {
        apply_lifecycle_rule = lookup(lifecycle_rule.value, "apply_lifecycle_rule", null)
      }
      expiration {
        days                         = lookup(lifecycle_rule.value, "expiration_days", null)
        expired_object_delete_marker = lookup(lifecycle_rule.value, "expired_object_delete_marker", null)
      }
      noncurrent_version_expiration {
        days = lookup(lifecycle_rule.value, "noncurrent_version_expiration_days", null)
      }
    }
  }
  //Enable default encryption
    server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm     = var.sse_algorithm
      }
    }
  }
}
