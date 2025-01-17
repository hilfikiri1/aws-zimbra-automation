resource "aws_vpc" "main_vpc" {
  cidr_block           = "10.123.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name = "dev"
  }
}
resource "aws_subnet" "main_public_subnet" {

  vpc_id                  = aws_vpc.main_vpc.id
  cidr_block              = "10.123.1.0/24"
  map_public_ip_on_launch = true # make_public_ip_address
  availability_zone       = "eu-north-1a"

  tags = {
    Name = "dev-public"
  }
}
resource "aws_internet_gateway" "main_internet_gateway" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "dev-igw"
  }
}
resource "aws_route_table" "main_public_rt" {
  vpc_id = aws_vpc.main_vpc.id

  tags = {
    Name = "dev_public_rt"
  }
}
resource "aws_route" "default_route" {
  route_table_id         = aws_route_table.main_public_rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_internet_gateway.id
}
resource "aws_route_table_association" "main_public_assoc" {
  subnet_id      = aws_subnet.main_public_subnet.id
  route_table_id = aws_route_table.main_public_rt.id
}
resource "aws_security_group" "main_sg" {
    name = "dev_sg"
    description = "dev security group" 
    vpc_id = aws_vpc.main_vpc.id

    ingress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
    
    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}
resource "aws_key_pair" "main_auth" {
    key_name = "mainkey"
    public_key = file("~/.ssh/aws_key.pub")
}
resource "aws_instance" "zimbra_server" {
    instance_type = "t3.large"
    count = var.instance_count
    ami = data.aws_ami.server_ami.id
    key_name = var.key_name
    vpc_security_group_ids = [aws_security_group.main_sg.id]
    subnet_id = aws_subnet.main_public_subnet.id

    user_data = file("userdata.tpl")

    tags = {
        Name = element(var.instance_names, count.index)
    }

    provisioner "local-exec" {
        command = templatefile("${var.host_os}-ssh-config.tpl", {
            hostname = self.public_ip,
            user = "ubuntu",
            identityfile = "~/.ssh/aws_key"
        })
        interpreter = ["bash", "-c"]
    }
}


