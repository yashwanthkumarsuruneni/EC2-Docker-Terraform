
locals {
  app_name = terraform.workspace == "default" ?  "mauvi" : "${terraform.workspace}-mauvi"
}


# This uses the default vpc
resource "aws_default_vpc" "default" {
}

################################################################################
## Security Group
################################################################################

resource "aws_security_group" "instance_sg" {
  name        = local.app_name
  description = "The security group to allow http & ssh"
  vpc_id      = aws_default_vpc.default.id
  
  ## Allow ssh from the internet
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ## Allow 4567 from the internet
  ingress {
    from_port   = 4567
    to_port     = 4567
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }
}

################################################################################
## EC2
################################################################################

resource "aws_instance" "root-mauvi" { 
  count                  = var.servers
  ami                    = data.aws_ami.amazon-linux.id
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.instance_sg.id]
  user_data              = file("${path.root}/scripts/userdata.sh")
  disable_api_termination = false

  tags = {
    Name = "${local.app_name}-${count.index}"
  }
}

################################################################################
## Deploy the container
################################################################################

resource "null_resource" "run-mauvi-container" {
  count = length(aws_instance.root-mauvi.*.id)

  triggers = {
    instance_id = join(",", aws_instance.root-mauvi.*.id) 
  }

  provisioner "remote-exec" {
    inline = [
      "sudo cloud-init status --wait &>/dev/null"
    ]
    connection  {
        type = "ssh"
        host = element(aws_instance.root-mauvi.*.public_ip, count.index) 
        user = "ec2-user"
        private_key = file("${var.key_name}.pem")
    }
  }

  provisioner "remote-exec" {
    inline = [
        "docker pull rootdevs/reliability-interview-container:201805",
        "docker run -d -p 4567:4567 --restart=always rootdevs/reliability-interview-container:201805"
    ]
    connection {
        type = "ssh"
        host = element(aws_instance.root-mauvi.*.public_ip, count.index) 
        user = "ec2-user"
        private_key = file("${var.key_name}.pem")
    }
  }

}

