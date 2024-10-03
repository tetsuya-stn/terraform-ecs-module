resource "aws_lb" "this" {
  name               = "${var.product_name}-${var.role}-${var.environment}-alb"
  load_balancer_type = "application"
  subnets            = var.subnet_ids
  security_groups    = var.security_groups
}

resource "aws_lb_target_group" "this" {
  name        = "${var.product_name}-${var.role}-${var.environment}-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "ip"

  health_check {
    path = "/"
  }
}

resource "aws_lb_listener" "this" {
  load_balancer_arn = aws_lb.this.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.this.arn
  }
}
