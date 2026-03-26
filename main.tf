provider "aws" {
    region = "us-east-1"
  
}

module "RDS"{
  source = "./modules/RDS"
  project = "cbz"
  environment = "dev"
  allocated_storage = 20
  max_allocated_storage = 100
  instance_class = "db.t3.micro"
  username = "admin"
  password = "password123"
} 
  

module "EKS" {

  source = "./modules/EKS"
  project = "cbz"
  environment = "dev"
    desired_nodes = 3
    max_nodes = 10
    min_nodes = 1
    node_instance_type = "t3.medium"

}

module "S3" {
    source = "./modules/S3"
    environment = "dev"
    bucket_name = "cbz-eks-bucket"

  
}