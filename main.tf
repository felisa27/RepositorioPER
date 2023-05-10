provider "aws" {
    region = "eu-west-1"
}

resource "aws_instance" "mi_servidor" {
    ami = "ami-1234"
    instance_type = "t2.micro"
vpc_secutity_group_ids = [aws_security_group.mi_grupo_de_seguridad.id]

  user_data = <<-EOF
  #!/bin/bash
  echo "Hola Terraformers!" > index.html
  nohup busybox httpd -f -p 8080 &
  EOF 
  tags = {
    Name = "servidor-1"
  } 
}

resource "aws_security_group" "mi_grupo_de_seguridad" {
    name = "primer-servidor-sg"

    ingress {
        cidr_blocks = ["0.0.0.0/0"]
        description = "Acceso al puerto 8080 desde el exterior"
        from_port = 8080
        to_port = 8080
        protocol = "TCP"
    }
}    
