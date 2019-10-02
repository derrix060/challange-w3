# create an S3 bucket to store the state file in
resource "aws_s3_bucket" "mario-terraform-state-storage" {
    bucket = "mario-terraform-remote-state-storage"

    # Enable versioning because might be good if need to rowback.
    versioning {
      enabled = true
    }

    # Prevent destroying remote state.
    lifecycle {
      prevent_destroy = true
    }
 
    tags = {
      Name = "S3 Remote Terraform State Store"
    }
}
