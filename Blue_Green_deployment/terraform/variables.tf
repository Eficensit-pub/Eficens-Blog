variable "aws_region" {
  description = "The AWS region to deploy resources."
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet IDs."
  type        = list(string)
}

variable "blue_security_group_ids" {
  description = "List of security group IDs for the blue environment."
  type        = list(string)
}

variable "green_security_group_ids" {
  description = "List of security group IDs for the green environment."
  type        = list(string)
}
