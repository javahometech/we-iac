# Create a new load balancer
resource "aws_elb" "elb" {
  name               = "javahome-we-elb"
  subnets = local.pub_sub_ids

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:80/index.html"
    interval            = 30
  }

  instances                   = [aws_instance.web.id]
  cross_zone_load_balancing   = true
  idle_timeout                = 60
  connection_draining         = true
  connection_draining_timeout = 60
  security_groups = [aws_security_group.web_sg.id]

  tags = {
    Name = "javahome-we-elb"
  }
}