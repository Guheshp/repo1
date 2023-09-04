provider "aws" {
  region = "ap-south-1"

}

resource "aws_instance" "namaste" {
  ami           = "ami-06f621d90fa29f6d0"
  instance_type = "t2.micro"
}


resource "aws_s3_bucket" "gps3" {
  bucket = "gp-tf-gps3-bucket"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.gps3.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.gps3.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.gps3.id
  acl    = "public-read"
}


output "instance_id" {
  value = aws_instance.namaste.id


}
output "aws_s3_bucket" {
  value = aws_s3_bucket.gps3.id


}
terraform {
  backend "s3" {
    bucket = "gp-tf-gps3-bucket"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}

resource "aws_vpc" "gp_vpc" {
  cidr_block = "10.0.0.0/20"


}

output "vpc_id" {
  value = aws_vpc.gp_vpc.id

}
