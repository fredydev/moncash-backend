

variable "aws_region" {
  description = "AWS region used by aws provider"
  type        = string
  default = "eu-west-3"
}
variable "environment" {
  description = "AWS region used by aws provider"
  type        = string
  default = "dev"
}
variable "profile_member_account" {
  description = "AWS member account profile"
  type        = string
  default = "default"
}

variable "secret_recovery_window_in_days" {
  description = "Secret recovery_window_in_days. Optional, its default value is 0"
  type        = number
  default = 0
}

# https://www.padok.fr/en/blog/terraform-workspaces



