resource "aws_security_group" "project-sg" {
  name       = "project-sg"
  dscription = "For project and opening some port for testing" 
  ingress = [
   for port in  [22, 80, 443,8080,9000,3000] : {
    description = "Allow SSH from anywhere"
    form_port  = port 
    to_port    = port 
    protocol   = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids = []
    security_groups = []
    self = false
  }
  ]

  egress = [
    {
      description = "Allow all outbound traffic by default"
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
}
  ]
  tags = {
    Name = "project-sg"
  }
}

resource "aws_instance" "project-ec2" {
  ami           = "ami-078c1149d8ad719a7"
  instance_type = "t2.xlarge"
  key_name      = "Project"
  security_groups = [aws_security_group.project-sg.id]
  user_data = templatefile("./userdata.sh")
  tags = {
    Name = "project-ec2"
  }
  root_block_device {
    volume_size = 30
  }
}
  

