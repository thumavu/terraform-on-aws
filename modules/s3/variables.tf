variable "bucket_name" {
  type        = string
  description = "s3 bucket name"
}

variable "elb_service_account_arn" {
  type        = string
  description = "load balance service account arn"
}

variable "common_tags" {
  type        = map(string)
  description = "load balance service account arn"
  default     = {}
}