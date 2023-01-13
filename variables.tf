variable "aws_region" {
  type        = string
  description = "AWS region to use for resources"
  default     = "us-east-1"
}

variable "naming_prefix" {
  type        = string
  description = "Naming prefix for all resources"
  default     = "sizwe"
}

variable "company" {
  type        = string
  description = "Company name"
  default     = "Nkosimi ltd"
}

variable "project" {
  type        = string
  description = "Project name"
}

variable "billing_code" {
  type        = string
  description = "Project name"
}

variable "ec2_instance_type" {
  type        = map(string)
  description = "ec2 instance type"
}

variable "enable_dns_hostnames" {
  type        = bool
  description = "enable dnt hostname"
  default     = true
}

variable "vpc_subnets_cdir_block" {
  type        = list(string)
  description = "CIDR Block for subnets in vpc"
  default     = ["10.0.0.0/24", "10.0.1.0/24"]
}

variable "vpc_cidr_block" {
  type        = map(string)
  description = "Base CIDR Block for VPC"
}

variable "aws_subnet_count" {
  type        = map(number)
  description = "Number of subnets to create"
}

variable "aws_instance_count" {
  type        = map(number)
  description = "Number of instances to create"
}