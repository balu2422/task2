provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "mytask_2bucket_hcl" {
  bucket = "mytask-2bucket-hcl"

  versioning {
    enabled = true
  }
}

resource "aws_s3_bucket_server_side_encryption_configuration" "mytask_2bucket_hcl" {
  bucket = aws_s3_bucket.mytask_2bucket_hcl.bucket

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm = "AES256"
    }
  }
}

resource "null_resource" "create_index_file" {
  provisioner "local-exec" {
    command = "echo 'hello' > index.html"
  }
}

resource "aws_s3_object" "index_file" {
  bucket = aws_s3_bucket.mytask_2bucket_hcl.bucket
  key    = "index.html"
  source = "index.html"

  depends_on = [null_resource.create_index_file]
}
