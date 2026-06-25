module "eks" {

  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.31"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {

    default = {

      instance_types = ["t3.medium"]

      min_size     = 2
      max_size     = 7
      desired_size = 4

      capacity_type = "ON_DEMAND"
    }
  }

  tags = {
    Project = var.project_name
  }
}