variable "bucket" {
  type        = string
  description = "Name of S3 Bucket"
  default = ""
}

variable "bucket_prefix" {
  type        = bool
  description = "Creates a unique bucket name beginning with the specified prefix"
  default     = false
}

variable "acl" {
  type        = string
  description = "Canned ACL of S3 Bucket"
  default     = "private"
}

variable "policy" {
  type        = string
  description = "Policy (JSON) Document of S3 Bucket"
  default     = null
}


variable "tags" {
  type        = map
  description = "Mapping of Tags of S3 Bucket"
  default     = {}
}

variable "force_destroy" {
  type        = bool
  description = "A boolean that indicates all objects (including any locked objects) should be deleted from the bucket so that the bucket can be destroyed without error"
  default     = true
}

variable "create_ptfm_bucket" {
  description = "Controls if Platform buckets needs to be created"
  type        = bool
  default     = false
}

variable "create_proj_bucket" {
  description = "Controls if Project buckets needs to be created"
  type        = bool
  default     = false
}

variable "create_generic_bucket" {
  description = "Controls if Generic bucket needs to be created"
  type        = bool
  default     = false
}

variable "create_bfx_fsx_bucket" {
  description = "Controls if Bfx Fsx buckets needs to be created"
  type        = bool
  default     = false
}

variable "create_da_fsx_bucket" {
  description = "Controls if Data Analytics Fsx buckets needs to be created"
  type        = bool
  default     = false
}

variable "content_type" {
  type        = string
  description = "Content type of the S3 object"
  default     = "application/x-directory"
}

variable "ptfm_s3_name_prefix" {
  type        = string
  description = "Platform S3 Bucket Prefix"
  default     = ""
}

variable "proj_s3_name_prefix" {
  type        = string
  description = "Project S3 Bucket Prefix"
  default     = ""
}

variable "bfx_fsx_s3_name_prefix" {
  type        = string
  description = "Data Analytics Fsx S3 Bucket Prefix"
  default     = ""
}

variable "da_fsx_s3_name_prefix" {
  type        = string
  description = "Data Analytics Fsx S3 Bucket Prefix"
  default     = ""
}


variable "region" {
  description = "The `Region Name where AWS resources will be deployed"
  type        = string
}

variable "sse_algorithm" {
  description = "The server-side encryption algorithm to use"
  type        = string
  default = "AES256"
}

#2972 download bucket
variable "create_download_bucket" {
  description = "Controls if Project buckets needs to be created"
  type        = bool
  default     = false
}

#iRDB changes starts
variable "irdb_access_enabled" {
  description = "Controls if Project has iRDB access or not"
  type        = bool
  default     = false
}

variable "project_uid" {
  type        = string
  description = "Project ID"
  default     = ""
}

variable "irdb_ingest_bucket_id" {
  type        = string
  description = "iRDB ingest S3 bucket ID"
  default     = ""
}
#iRDB changes ends