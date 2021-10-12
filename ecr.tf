resource "aws_ecr_repository" "lwolynski-repository" {
  name                 = "lwolynski-repository"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}
output "repository_url" {
  value = aws_ecr_repository.lwolynski-repository.repository_url
}

provider "aws" {
  region = "eu-central-1"
}
