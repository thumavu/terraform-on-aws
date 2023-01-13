module "web_app_s3" {
  source = "./modules/s3"

  bucket_name             = local.s3_bucket_name
  elb_service_account_arn = data.aws_elb_service_account.admin.arn
  common_tags             = local.common_tags
}

# aws_s3_bucket_object
resource "aws_s3_bucket_object" "object" {
  for_each = fileset("./website/", "*")

  bucket = module.web_app_s3.web_bucket.id
  key    = "/website/${each.value}"
  source = "./website/${each.value}"

  # The filemd5() function is available in Terraform 0.11.12 and later
  # For Terraform 0.11.11 and earlier, use the md5() function and the file() function:
  # etag = "${md5(file("path/to/file"))}"
  etag = filemd5("./website/${each.value}")
}