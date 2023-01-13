#! /bin/bash
sudo amazon-linux-extras install -y nginx1
sudo service nginx start
aws s3 cp s3://${s3_bucket_name}/website/index-2.html /home/ec2-user/index.html
aws s3 cp s3://${s3_bucket_name}/website/web-app-2.jpeg /home/ec2-user/web-app.jpeg
sudo rm /usr/share/nginx/html/index.html
sudo cp /home/ec2-user/index.html /usr/share/nginx/html/index.html
sudo cp /home/ec2-user/web-app.jpeg /usr/share/nginx/html/web-app.jpeg
