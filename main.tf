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
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": "s3:ListBucket",
      "Resource": "arn:aws:s3:::my524bucket5omar5hamdaa:"
    },
    {
      "Effect": "Allow",
      "Action": ["s3:GetObject", "s3:PutObject", "s3:DeleteObject"],
      "Resource": "arn:aws:s3:::my524bucket5omar5hamdaa/path/to/my/key"
    }
  ]
}
