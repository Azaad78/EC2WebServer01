resource "aws_network_interface" "primary_network_interface" {
  subnet_id   = aws_subnet.public_subnet01.id
  security_groups = [aws_security_group.sg_allow_http.id]

  tags = {
    Name = "primary_network_interface"
  }
}
//azaadknowledgekey01 
resource "aws_instance" "web-server" {
  ami           = "ami-03ca998611da0fe12"
  instance_type = "t2.micro"
  user_data = file("./public.userdata.sh")
  # user_data = <<-EOF
  #               #!/usr/bin/env bash
  #               su ec2-user
  #               sudo yum install httpd -y
  #               sudo service httpd start
  #               sudo su -c "cat > /var/www/html/index.html <<EOL
  #               <html>
  #                   <head>
  #                       <title>Welcome to TomyumAdventures</title>
  #                       <style>
  #                           html, body { background: #000; padding: 0; margin: 0;}
  #                           img {display: block; max-width: 0px auto;}
  #                       </style>
  #                   </head>
  #                   <body>
  #                       <img src='https://i.ytimg.com/vi/OYr3P6Vq8yU/maxresdefault.jpg' 'height=100%'/>
  #                   </body>
  #               </html>
  #               EOL"
  #               EOF

  tags = {
    Name = "web-server"
  }
  network_interface {
    network_interface_id = aws_network_interface.primary_network_interface.id
    device_index         = 0
  }

}