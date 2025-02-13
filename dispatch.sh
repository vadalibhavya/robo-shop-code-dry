source common.sh
component=dispatch
dnf install golang -y
cp dispatch.service /etc/systemd/system/dispatch.service
useradd roboshop
artifact_download
cd /app
go mod init dispatch
go get
go build
systemd_setup