provider "aws" {
  region = "us-west-2"
}

variable "team-name" {
  description = "team-name"
  type        = string
  default     = "default-team-name"
}

resource "aws_instance" "web" {
  ami           = "ami-0d6e8758b9f426d84"
  instance_type = "t2.micro"

  tags = {
    Name = var.team-name
  }
}

output "public_ip" {
  value       = aws_instance.web.public_ip
  description = "Public IP of the instance"
}

terraform {
   backend "s3" {
 # Replace this with your bucket name!
   bucket         = "ot-infra-state"
   key            = "global/s3/terraform-holly-drill.tfstate"
   region         = "us-east-1"
   }
}

#resource "aws_s3_bucket" "terraform_state" {
#  bucket = "${team_name}-terraform-state"
#
#  # Prevent accidental deletion of this S3 bucket
#  lifecycle {
#    prevent_destroy = true
#  }
#
#  # Enable versioning so we can see the full revision history of our
#  # state files
#  versioning {
#    enabled = true
#  }
#
#  # Enable server-side encryption by default
#  server_side_encryption_configuration {
#    rule {
#      apply_server_side_encryption_by_default {
#        sse_algorithm = "AES256"
#      }
#    }
#  }
#}
#
#resource "aws_dynamodb_table" "terraform_locks" {
#    name         = "terraform-up-and-running-locks"
#    billing_mode = "PAY_PER_REQUEST"
#    hash_key     = "LockID"
#
#    attribute {
#      name = "LockID"
#      type = "S"
#    }
#}
#
#terraform {
#    backend "s3" {
#  # Replace this with your bucket name!
#    bucket         = "terraform-up-and-running-state"
#    key            = "global/s3/terraform.tfstate"
#    region         = "us-east-2"
#
#  # Replace this with your DynamoDB table name!
#    dynamodb_table = "terraform-up-and-running-locks"
#    encrypt        = true
#    }
#}
#
#output "s3_bucket_arn" {
#    value       = aws_s3_bucket.terraform_state.arn
#    description = "The ARN of the S3 bucket"
#}
#
#output "dynamodb_table_name" {
#    value       = aws_dynamodb_table.terraform_locks.name
#    description = "The name of the DynamoDB table"
#}
