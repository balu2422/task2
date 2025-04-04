provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "mybuckt1122" {
  bucket = "mybuckt1122"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

resource "null_resource" "create_index_file" {
  provisioner "local-exec" {
    command = "echo 'hello' > index.html"
  }
}

resource "aws_s3_bucket_object" "index_file" {
  bucket = aws_s3_bucket.mybuckt1122.bucket
  key    = "index.html"
  source = "index.html"
  acl    = "public-read"

  depends_on = [null_resource.create_index_file]
}
