source common.sh
component=dispatch
message "Installing golang"
dnf install golang -y
message " copying the $component service file"
cp $component.service /etc/systemd/system/$component.service
status_check $?
id roboshop
if [ $? -ne 0 ]; then
  useradd roboshop
fi
mkdir /app
curl -L -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
status_check $?
cd /app
unzip /tmp/$component.zip
cd /app
go mod init $component
go get
go build
systemrestart $component
