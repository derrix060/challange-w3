# This will be used to get the app image from
resource "aws_ecr_repository" "ecr_repo" {
  name = "web-app"
}
