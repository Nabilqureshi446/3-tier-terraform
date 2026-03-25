variable "environment" {
  default = "dev"
  
}
variable "allocated_storage" {
  default = 20
}       
variable "max_allocated_storage" {
  default = 100
}
variable "instance_class" {
  default = "db.t3.micro"
}
variable "username" {
  default = "admin"
}

variable "password" {
  default = "Admin123!"
}       
variable "project" {
  default = "cbz"
}