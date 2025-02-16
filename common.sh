# This function is used to set up the systemd service for the given component.
# It reloads the systemctl daemon, enables the component and starts it.
systemd_setup() {
  print_message "Setting up systemd service for $component"
  systemctl daemon-reload && systemctl enable $component && systemctl start $component
}

artifact_download() {
  print_message "Downloading $component artifact"
  rm -rf /app && mkdir /app &&
  curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
  print_message "Extracting $component artifact"
  && cd /app
  && unzip /tmp/$component.zip
}

node_setup() {
  print_message "Installing $component"
  dnf module disable nodejs -y &&  print_message enabling the nodejs &&
  dnf module enable nodejs:20 -y && print_message Copying the service file &&
  cp $component.service /etc/systemd/system/$component.service &&
  dnf install nodejs -y &&
  useradd roboshop && artifact_download &&
  cd /app && npm install && systemd_setup
}

print_message() {
  echo -e "\033[32m$1\033[0m"
}

print_info() {
  echo -e "\033[34m$1\033[0m"
}