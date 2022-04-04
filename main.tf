provider "aws" {
  region = "us-west-2"
}


resource "aws_vpc" "main" {
		cidr_block = "20.0.0.0/24"
}

terraform {
  backend "s3" {
   region = "us-west-2"
   key = "statefile/s3"
   bucket = "my524bucket5omar5hamdaa"
  }
}

