locals {
  common_tags = {
    company = var.company
    project = "terraform on aws"
    billing_code = var.billing_code
  }
}