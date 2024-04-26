variable "private_key" {
  default = "dev-comfy"
}

variable "security_group_id" {
  default = "sg-099747e23c4ae7ccc"
}

variable "instance_tag" {
  default = "asg_child"
}

variable "launch_template_1_name" {
  default = "lt_1_t3_micro"
}

variable "launch_template_2_name" {
  default = "lt_2_t3_medium"
}

variable "lt_1_ami_id" {
  default = "ami-080e1f13689e07408"
}

variable "lt_2_ami_id" {
  default = "ami-0cd59ecaf368e5ccf"
}

variable "instance_type" {
  default = "t3.xlarge"
}

variable "lt_1_volume_size" {
  default = 30
}

variable "lt_1_volume_type" {
  default = "gp2"
}

variable "lt_2_volume_size" {
  default = 30
}

variable "lt_2_volume_type" {
  default = "gp2"
}

variable "iops" {
  default = 100
}

variable "environment_tag" {
  default = "dev"
}

variable "as_group_1" {
  default = "child-asg-1"
}

variable "as_group_1_min_size" {
  default = 1
}

variable "as_group_1_max_size" {
  default = 2
}

variable "as_group_1_desire_size" {
  default = 1
}

variable "as_group_2" {
  default = "child-asg-2"
}

variable "as_group_2_min_size" {
  default = 2
}

variable "as_group_2_max_size" {
  default = 3
}

variable "as_group_2_desire_size" {
  default = 2
}

variable "target_group_arns" {
  type = list(string)
  default = [
    "arn:aws:elasticloadbalancing:us-east-1:108051779495:targetgroup/child-machines-tg/aea2e0004268993b"
  ]
}