

resource "aws_lb_target_group" "apphost-group" {
  name                          = "apphost-group"
  load_balancing_algorithm_type = "round_robin"
  port                          = 80
  protocol                      = "HTTP"
  protocol_version              = "HTTP1"
  slow_start                    = "0"
  target_type                   = "instance"
  vpc_id                        = var.vpc_id

  health_check {
    enabled             = "true"
    healthy_threshold   = "5"
    interval            = "30"
    matcher             = "200"
    path                = "/health/"
    port                = "traffic-port"
    protocol            = "HTTP"
    timeout             = "5"
    unhealthy_threshold = "2"
  }
}

resource "aws_lb_target_group_attachment" "instances" {
  target_group_arn = aws_lb_target_group.apphost-group.arn
  target_id        = aws_instance.apphost1.id
}


resource "aws_lb" "apphost-elb" {
  name               = "apphost-elb"
  internal           = false
  ip_address_type    = "ipv4"
  load_balancer_type = "application"
  security_groups    = [ aws_security_group.apphost-sg.id ]
  subnets = ["subnet-50fbbe2a", "subnet-1265ee5e"]
}


resource "aws_lb_listener" "lb_listener_http" {
   load_balancer_arn    = aws_lb.apphost-elb.id
   port                 = "80"
   protocol             = "HTTP"
   default_action {
    target_group_arn = aws_lb_target_group.apphost-group.id
    type             = "forward"
  }
}
