
#!/bin/bash
apt update -y
apt install -y nginx
systemctl start nginx
systemctl enable nginx
# We even use the Terraform variable inside the server!
echo "<h1>Hello from Terraform Locals Demo  environment)</h1>" > /var/www/html/index.html
