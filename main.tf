provider "aws" {
  region = "us-west-2"
}


resource "aws_vpc" "main" {
		cidr_block = "10.0.0.0/24"
}

terraform {
  backend "s3" {
   region = "us-west-2"
   key = "statefile"
   bucket = "my524bucket5omar5hamdaa"
  }
}
