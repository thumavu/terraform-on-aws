##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

data "aws_availability_zones" "available" {
  state = "available"
}

##################################################################################
# RESOURCES
##################################################################################


module "vpc" {
  source = "terraform-aws-modules/vpc/aws"
  version = "=3.18.1"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = slice(data.aws_availability_zones.available.names, 0, (var.aws_subnet_count))
  public_subnets  = [for subnet in range(var.aws_subnet_count) : cidrsubnet(var.vpc_cidr_block, 8, subnet)]

  enable_nat_gateway = false
  enable_vpn_gateway = false

  tags = merge(local.common_tags, {Name = "${local.name_prefix}-vpc"})
}

# SECURITY GROUPS #
# Nginx security group 
resource "aws_security_group" "nginx-sg" {
  name   = "nginx_sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }
  tags = local.common_tags
}

# Nginx security group 2
resource "aws_security_group" "nginx-alb-sg" {
  name   = "nginx_alb_sg"
  vpc_id = module.vpc.vpc_id

  # HTTP access from anywhere
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr_block]
  }

  # outbound internet access
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.vpc_cidr_block]
  }
  tags = local.common_tags
}