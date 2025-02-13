source common.sh
component=catalogue
dnf module disable nodejs -y
dnf module enable nodejs:20 -y
dnf install nodejs -y
cp catalogue.service /etc/systemd/system/catalogue.service
cp mongo.repo /etc/yum.repos.d/mongo.repo
useradd roboshop
artifact_download
cd /app
npm install

systemd_setup

dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.doubtfree.online </app/db/master-data.js
