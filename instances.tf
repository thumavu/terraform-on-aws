##################################################################################
# DATA
##################################################################################

data "aws_ssm_parameter" "ami" {
  name = "/aws/service/ami-amazon-linux-latest/amzn2-ami-hvm-x86_64-gp2"
}

# INSTANCES #
resource "aws_instance" "nginx" {
  count                  = var.aws_instance_count[terraform.workspace]
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.ec2_instance_type[terraform.workspace]
  subnet_id              = module.vpc.public_subnets[(count.index % var.aws_subnet_count[terraform.workspace])]
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  iam_instance_profile   = module.web_app_s3.instance_profile.name

  depends_on = [
    module.web_app_s3
  ]

  user_data = templatefile("${path.module}/startup_script${count.index + 1}.sh", {
    s3_bucket_name = module.web_app_s3.web_bucket.id
  })

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-instance-${count.index}" })
}