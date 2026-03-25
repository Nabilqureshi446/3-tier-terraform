variable "project"{
  default = "cbz"
  
}

variable "environment" {
  default = "dev"
  
}

variable "desired_nodes" {
  default = 3
}

variable "max_nodes" {
  default = 10
}

variable "min_nodes" {
  default = 1
}

variable "node_instance_type" {
  default = "t3.medium"
}