locals {
  common_tags = {
    company = var.company
    project = "terraform on aws"
    billing_code = var.billing_code
  }

  s3_bucket_name = "web-app-${random_integer.rand.result}"
}

resource "random_integer" "rand" {
  min = 10000
  max = 99999
}

