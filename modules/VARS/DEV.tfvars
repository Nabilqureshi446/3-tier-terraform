region = "ap-south-1"

# Eks 
aws_eks_cluster_name = "my-eks-cluster"

# EKS Node Group desired, max, and min size
desired_size =1
max_size =3
min_size = 1
instance_types = ["t3.medium"]


# RDS

allocated_storage = 10
max_allocated_storage = 20
instance_class = "db.t3.micro"
username = "admin"
password = "Admin1234" 


# S3

bucket = "nabil-teste123"