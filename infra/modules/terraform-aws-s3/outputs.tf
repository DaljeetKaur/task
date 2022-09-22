
output "region_download_s3_id" {
  description = "List of platform S3 buckets"
  value       = concat(aws_s3_bucket.region_download_s3_bucket.*.id,[""])[0]
}