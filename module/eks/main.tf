resource "aws_iam_role" "eks_cluster_role" {
  name = "eks_cluster_role-${var.project}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Environment = var.environment 
  } 
}


resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
    role =  aws_iam_role.eks_cluster_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "eks_service_policy" {
    role =  aws_iam_role.eks_cluster_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  
}

resource "aws_iam_role" "eks_node_group_role" {
  name = "eks_node_group_role-${var.project}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      }
    ]
  })
  tags = {
    Environment = var.environment 
  } 
  
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
    role =  aws_iam_role.eks_node_group_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
    role =  aws_iam_role.eks_node_group_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  
}

resource "aws_iam_role_policy_attachment" "ec2_container_policy" {
    role =  aws_iam_role.eks_node_group_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  
}

data "aws_vpc" "default" {
  default = true
  
}

data "aws_subnet" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }

  
}
resource "aws_eks_cluster" "cbz_cluster" {
  name     = "${var.project}-cluster-${var.environment}"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = data.aws_subnet.default.id
  }
  depends_on = [  
   aws_iam_role_policy_attachment.eks_cluster_policy,
    aws_iam_role_policy_attachment.eks_service_policy

  ]
   

  tags = {
    Environment = var.environment 
  }
  
}

resource "aws_eks_node_group" "cbz_nodegroup" {
  cluster_name    = aws_eks_cluster.cbz_cluster.name
  node_group_name = "${var.project}-node-group-${var.environment}"
  node_role_arn   = aws_iam_role.eks_node_role.arn
  subnet_ids      = data.aws_subnets.default.ids

  scaling_config {
    desired_size = var.desired_nodes
    max_size     = var.max_nodes
    min_size     = var.min_nodes
  }

  instance_types = [var.node_instance_type]

  depends_on = [
    aws_iam_role_policy_attachment.eks_worker_node_policy,
    aws_iam_role_policy_attachment.eks_cni_policy,
    aws_iam_role_policy_attachment.ec2_container_policy
  ]

  tags = {
    Environment = var.environment
  }
}