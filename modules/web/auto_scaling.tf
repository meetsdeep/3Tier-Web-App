# ---------------------------------------------------------------------------------------------------------------------
# AUTO SCALING GROUP
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_autoscaling_group" "autoscaling_group" {
  launch_configuration = "${aws_launch_configuration.launch_configuration.id}"
  vpc_zone_identifier  = ["${var.private_subnet_b}", "${var.private_subnet_c}"]
  min_size             = 1
  max_size             = 3
  desired_capacity=    2
  load_balancers       = ["${aws_elb.elb.name}"]
  health_check_type    = "ELB"

  tag {
    key                 = "Name"
    value               = "autoscaling_group"
    propagate_at_launch = true
  }
}

# ---------------------------------------------------------------------------------------------------------------------
# LAUNCH CONFIGURATION
# ---------------------------------------------------------------------------------------------------------------------

resource "aws_launch_configuration" "launch_configuration" {
  image_id             = "ami-37df2287"
  instance_type        = "t3.medium"
  security_groups      = ["${var.private_sg}"]
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"
  user_data="${data.template_file.userdata.rendered}"
  
  root_block_device= {
  
  volume type= "gp2"
  volume_size="100"
  delete_on_termination="true"

}
lifecycle {

create_before_destroy=true

}

}  
data"template_file" "userdata" {

template="${file("${path.module}/userdata.tpl")}"
  
}
  

