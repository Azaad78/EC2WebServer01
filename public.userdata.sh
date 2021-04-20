#!/usr/bin/env bash
su ec2-user
sudo yum install httpd -y
sudo service httpd start
sudo su -c "cat > /var/www/html/index.html <<EOL
<html>
    <head>
        <title>Welcome to TomyumAdventures</title>
        <style>
            html, body { background: #000; padding: 0; margin: 0;}
            img {display: block; max-width: 0px auto;}
        </style>
    </head>
    <body>
        <img src='https://i.ytimg.com/vi/OYr3P6Vq8yU/maxresdefault.jpg' 'height=100%'/>
    </body>
</html>
EOL"