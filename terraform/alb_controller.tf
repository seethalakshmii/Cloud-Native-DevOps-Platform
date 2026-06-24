# EKS DATA

data "aws_eks_cluster" "eks" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "eks" {
  name = module.eks.cluster_name
}


# EXISTING AWS POLICY
data "aws_iam_policy" "alb_controller" {
  arn = "arn:aws:iam::622488711452:policy/AWSLoadBalancerControllerIAMPolicy"
}


# KUBERNETES PROVIDER

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}


# HELM PROVIDER

provider "helm" {
  kubernetes {
    host                   = data.aws_eks_cluster.eks.endpoint
    cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
    token                  = data.aws_eks_cluster_auth.eks.token
  }
}

# IRSA TRUST POLICY

data "aws_iam_policy_document" "alb_assume_role" {

  statement {

    actions = [
      "sts:AssumeRoleWithWebIdentity"
    ]

    principals {
      type = "Federated"

      identifiers = [
        module.eks.oidc_provider_arn
      ]
    }

    condition {
      test = "StringEquals"

      variable = "${replace(module.eks.cluster_oidc_issuer_url, "https://", "")}:sub"

      values = [
        "system:serviceaccount:kube-system:aws-load-balancer-controller"
      ]
    }
  }
}


# IAM ROLE

resource "aws_iam_role" "alb_controller" {

  name = "task5-eks-alb-controller-role"

  assume_role_policy = data.aws_iam_policy_document.alb_assume_role.json
}


# ATTACH EXISTING POLICY

resource "aws_iam_role_policy_attachment" "alb_controller" {

  role       = aws_iam_role.alb_controller.name
  policy_arn = data.aws_iam_policy.alb_controller.arn
}


# SERVICE ACCOUNT

resource "kubernetes_service_account" "alb_controller" {

  metadata {

    name      = "aws-load-balancer-controller"
    namespace = "kube-system"

    annotations = {
      "eks.amazonaws.com/role-arn" = aws_iam_role.alb_controller.arn
    }
  }
}


# AWS LOAD BALANCER CONTROLLER

resource "helm_release" "aws_load_balancer_controller" {

  name       = "aws-load-balancer-controller"
  repository = "https://aws.github.io/eks-charts"
  chart      = "aws-load-balancer-controller"

  namespace = "kube-system"

  set {
    name  = "clusterName"
    value = module.eks.cluster_name
  }

  set {
    name  = "serviceAccount.create"
    value = "false"
  }

  set {
    name  = "serviceAccount.name"
    value = "aws-load-balancer-controller"
  }

  set {
    name  = "region"
    value = "us-west-1"
  }

  set {
    name  = "vpcId"
    value = module.vpc.vpc_id
  }

  depends_on = [
    kubernetes_service_account.alb_controller
  ]
}