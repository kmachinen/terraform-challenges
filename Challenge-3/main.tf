# Generate an SSH key pair
resource "tls_private_key" "citadel" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# Save the private key to a file
resource "local_file" "private_key" {
  content         = tls_private_key.citadel.private_key_pem
  filename        = "${path.module}/citadel_private_key.pem"
  file_permission = "0600" # Restrict access to the private key
}

# Save the public key to a file
resource "local_file" "public_key" {
  content  = tls_private_key.citadel.public_key_openssh
  filename = "${path.module}/citadel_public_key.pub"
}

# Create an AWS key pair using the generated public key
resource "aws_key_pair" "citadel_key" {
  key_name   = "citadel"
  public_key = tls_private_key.citadel.public_key_openssh
}

resource "aws_security_group" "citadel_sg" {
  name        = "citadel-security-group"
  description = "Allow SSH and other traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Launch an EC2 instance using the created key pair
resource "aws_instance" "citadel" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name      = aws_key_pair.citadel_key.key_name

  # Load user_data from a script
  user_data = file("${path.module}/install-nginx.sh")

  vpc_security_group_ids = [aws_security_group.citadel_sg.id]

  tags = {
    Name = "citadel"
  }
}

# Associate an Elastic IP with the instance
resource "aws_eip" "citadel_eip" {
  instance = aws_instance.citadel.id

  provisioner "local-exec" {
    command = "echo ${self.public_dns} > ${path.module}/citadel_public_dns.txt"
  }
}
