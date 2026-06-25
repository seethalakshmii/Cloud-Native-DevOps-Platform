resource "aws_secretsmanager_secret" "db" {
  name = "${var.project_name}-db-secret"
}

resource "aws_secretsmanager_secret_version" "db" {
  secret_id = aws_secretsmanager_secret.db.id

  secret_string = jsonencode({
    username = var.db_username
    password = var.db_password
    host     = aws_db_instance.mysql.address
    database = var.db_name
  })
}