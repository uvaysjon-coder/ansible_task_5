provider "aws" {
  region = "eu-west-1"
}

# Create AmazonLinux instance
resource "aws_instance" "my_AmazonLinux" {
  ami           = "ami-0d71ea30463e0ff8d"
  instance_type = "t2.micro"
  key_name      = "ssh_key"
  tags = {
    Name    = "Ansible-Master-AmazonLinux"
    Owner   = "Uvaysjon Kholboev"
    Project = "Ansible Tasks"
  }
  vpc_security_group_ids = [aws_security_group.my_AmazonLinux.id]
}

# Create Ubuntu instance
resource "aws_instance" "my_Ubuntu_1" {
  ami           = "ami-0d75513e7706cf2d9"
  instance_type = "t2.micro"
  key_name      = "ssh_key"
  tags = {
    Name    = "Ansible-Client-1-Ubuntu"
    Owner   = "Uvaysjon Kholboev"
    Project = "Ansible Tasks"
  }
  vpc_security_group_ids = [aws_security_group.my_Ubuntu.id]
}

# Create Ubuntu instance
resource "aws_instance" "my_Ubuntu_2" {
  ami           = "ami-0d75513e7706cf2d9"
  instance_type = "t2.micro"
  key_name      = "ssh_key"
  tags = {
    Name    = "Ansible-Client-2-Ubuntu"
    Owner   = "Uvaysjon Kholboev"
    Project = "Ansible Tasks"
  }
  vpc_security_group_ids = [aws_security_group.my_Ubuntu.id]
}

resource "aws_security_group" "my_Ubuntu" {

  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My_Ubuntu_Security_Group "
  }
}

resource "aws_security_group" "my_AmazonLinux" {

  dynamic "ingress" {
    for_each = ["22", "80", "443"]
    content {
      from_port   = ingress.value
      to_port     = ingress.value
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }


  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "My_AmazonLinux_Security_Group "
  }
}
