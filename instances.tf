# INSTANCES #
resource "aws_instance" "nginx" {
  count = var.aws_instance_count
  ami                    = nonsensitive(data.aws_ssm_parameter.ami.value)
  instance_type          = var.ec2_instance_type
  subnet_id              = aws_subnet.subnets[(count.index % var.aws_subnet_count )].id
  vpc_security_group_ids = [aws_security_group.nginx-sg.id]
  iam_instance_profile   = aws_iam_instance_profile.nginx_profile.name
  depends_on = [
    aws_iam_role_policy.allow_s3_all
  ]
  user_data = templatefile("${path.module}/startup_script.sh", {
    s3_bucket_name = aws_s3_bucket.web-app.id
  })
  tags      = local.common_tags
}