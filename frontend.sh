source common.sh
message "Disable and Installing Nginx"
dnf module disable nginx -y
dnf module enable nginx:1.24 -y
dnf install nginx -y
status_check $?
message "Copying Nginx Configuration File"
cp nginx.conf /etc/nginx/nginx.conf
status_check $?

systemctl start nginx
systemctl enable nginx
rm -rf /usr/share/nginx/html/*
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip
cd /usr/share/nginx/html
unzip /tmp/frontend.zip
systemctl restart nginx