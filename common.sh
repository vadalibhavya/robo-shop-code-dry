# This function is used to set up the systemd service for the given component.
# It reloads the systemctl daemon, enables the component and starts it.
systemd_setup() {
  systemctl daemon-reload && systemctl enable $component && systemctl start $component
}

artifact_download() {
  rm -rf /app && mkdir /app && curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip && cd /app && unzip /tmp/$component.zip
}

node_setup() {
  dnf module disable nodejs -y && dnf module enable nodejs:20 -y && cp $component.service /etc/systemd/system/$component.service && dnf install nodejs -y && useradd roboshop && artifact_download && cd /app && npm install && systemd_setup
}

print_message() {
  echo -e "\033[32m$1\033[0m"
}

print_info() {
  echo -e "\033[34m$1\033[0m"
}