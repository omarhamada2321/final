provider "aws" {
  region = "us-west-2"
}


resource "aws_vpc" "main" {
  cidr_block = "40.0.0.0/16"
}

resource "aws_subnet" "subnet1" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "40.0.1.0/24"

  tags = {
    Name = "subnet1"
  }
}

resource "aws_subnet" "subnet2" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "40.0.2.0/24"

  tags = {
    Name = "subnet2"
  }
}




resource "aws_internet_gateway" "public-subnet-igw" {
  vpc_id  = aws_vpc.main.id

tags = {
        Name = "public-subnet-igw"
    }

}


resource "aws_route_table" "public-route" {
  vpc_id = aws_vpc.main.id

  route {
     cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.public-subnet-igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}


resource "aws_route_table_association" "public-subnet1-association" {
  subnet_id= aws_subnet.subnet1.id
  route_table_id = aws_route_table.public-route.id
}



resource "aws_route_table_association" "public-subnet2-association" {
  subnet_id= aws_subnet.subnet2.id
  route_table_id = aws_route_table.public-route.id
}

terraform {
  backend "s3" {
   region = "us-west-2"
   key = "statefile/s3"
   bucket = "my524bucket5omar5hamdaa"
  }
}
resource "aws_security_group" "public-sg" {
    name = "public-sg"
    description = "Allow connection to public instances connections."

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 443
        to_port = 443
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = -1
        to_port = -1
        protocol = "icmp"
        cidr_blocks = ["0.0.0.0/0"]
    }

      egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }  

    vpc_id = aws_vpc.main.id

    tags = {
        Name = "public-sg"
    }

}
resource "aws_instance" "web" {
 ami = "ami-0c02fb55956c7d316"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.public-sg.id]
  tags = {
    Name = "web_server"
  }
}



