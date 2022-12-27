variable "aws_access_key" {
    type = string
    description = "AWS Access Key"
    sensitive = true
}

variable "aws_secret_key" {
    type = string
    description = "AWS Secret Key"
    sensitive = true
}

variable "aws_region" {
    type = string
    description = "AWS region to use for resources"
    default = "us-east-1"
}

variable "company" {
    type = string
    description = "Company name"
    default = "Nkosimi (pty) ltd"
}

variable "project" {
    type = string
    description = "Project name"
}

variable "billing_code" {
    type = string
    description = "Project name"
}

variable "ec2_instance_type" {
    type = string
    description = "ec2 instance type"
    default = "t2.micro"
}

variable "enable_dns_hostnames" {
    type = bool
    description = "enable dnt hostname"
    default = true
}