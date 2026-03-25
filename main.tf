provider "aws" {
    region = "us-east-1"
  
}

module "rds"{
  source = "./modules/rds"
  project = "cbz"
  environment = "dev"
  allocated_storage = 20
  max_allocated_storage = 100
  instance_class = "db.t3.micro"
  username = "admin"
  password = "password123"
} 
  

module "eks" {

  source = "./modules/eks"
  project = "cbz"
  environment = "dev"
    desired_nodes = 3
    max_nodes = 10
    min_nodes = 1
    node_instance_type = "t3.medium"

}

module "s3" {
    source = "./modules/s3"
    environment = "dev"
    bucket_name = "cbz-eks-bucket"

  
}