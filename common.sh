# This function is used to set up the systemd service for the given component.
# It reloads the systemctl daemon, enables the component and starts it.
systemd_setup() {
  # Reload the systemctl daemon to pick up the new service file.
  systemctl daemon-reload
  # Enable the component to start on boot.
  systemctl enable $component
  # Start the component.
  systemctl start $component
}

artifact_download(){
  rm -rf /app
 mkdir /app
 curl -o /tmp/$component.zip https://roboshop-artifacts.s3.amazonaws.com/$component-v3.zip
 cd /app
 unzip /tmp/$component.zip
}

node_setup(){
  dnf module disable nodejs -y
  dnf module enable nodejs:20 -y
  cp $component.service /etc/systemd/system/$component.service
  dnf install nodejs -y
  useradd roboshop
  artifact_download
  cd /app
  npm install
  systemd_setup
}