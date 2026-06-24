output "s3_bucket" {
  value = aws_s3_bucket.uploads.bucket
}

output "lambda_name" {
  value = aws_lambda_function.notify.function_name
}

output "github_role_arn" {
  value = aws_iam_role.github_actions.arn
}

output "backend_ecr" {
  value = aws_ecr_repository.backend.repository_url
}

output "frontend_ecr" {
  value = aws_ecr_repository.frontend.repository_url
}