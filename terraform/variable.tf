variable "olympic_analysis_security_group_name" {
  type        = string
  description = "Name of the security group"
  default     = "olympic_analysis_sg"
}

variable "olympic_analysis_security_group_description" {
  type        = string
  description = "Description of the security group"
  default     = "This security group rules are specifically created for this project"
}

variable "olympic_analysis_key_name" {
  type        = string
  description = "Name for the key_pair"
  default     = "olympic_analysis_key"
}
variable "olympic_analysis_instance_type" {
  type        = string
  description = "type of instance needed"
  default     = "t3.micro"
}
variable "olympic_analysis_root_volume_size" {
  type        = number
  description = "the size of the volume needed"
  default     = 8
}
variable "olympic_analysis_root_volume_type" {
  type        = string
  description = "type of volume required"
  default     = "gp3"
}
variable "olympic_analysis_ami_id" {
  type        = string
  description = "ami id"
  default     = "ami-020cba7c55df1f615"
}
variable "olympic_analysis_ingress_ports" {
  type        = list(number)
  description = "different ports needed for inbound traffic as per the requirement"
  default     = [80, 443, 8501, 8000]
}
