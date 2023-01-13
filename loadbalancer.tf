# aws_elb_service_account

data "aws_elb_service_account" "admin" {}

# aws_lb

resource "aws_lb" "nginx" {
  name               = "web-app-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.nginx-alb-sg.id]
  subnets            = module.vpc.public_subnets

  enable_deletion_protection = false

  access_logs {
    bucket  = module.web_app_s3.web_bucket.id
    prefix  = "alb-logs"
    enabled = true
  }
  tags = merge(local.common_tags, { Name = "${local.name_prefix}-alb" })

}

# aws_lb_target_group

resource "aws_lb_target_group" "nginx" {
  name     = "nginx-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = module.vpc.vpc_id

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-target-group" })

}

# aws_lb_listener

resource "aws_lb_listener" "nginx" {
  load_balancer_arn = aws_lb.nginx.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nginx.arn
  }

  tags = merge(local.common_tags, { Name = "${local.name_prefix}-lb-listener" })
}

# aws_lb_target_group_attachment

resource "aws_lb_target_group_attachment" "nginx" {
  count            = var.aws_instance_count[terraform.workspace]
  target_group_arn = aws_lb_target_group.nginx.arn
  target_id        = aws_instance.nginx[count.index].id
  port             = 80
}
