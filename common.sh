message() {
  echo -e "\e[32m$1\e[0m"
}

status_check() {
  if [ "$1" -eq 0 ]; then
    message "successful"
  else
    message "failed"
    exit 1
  fi
}

systemrestart(){
  systemctl daemon-reload
  systemctl enable "$1"
  systemctl start "$1"
}

useradd() {
  message "Disabling Node js"
  dnf module disable nodejs -y
  status_check $?

  message "Enabling Node js 20"
  dnf module enable nodejs:20 -y
  status_check $?

  # shellcheck disable=SC2027
  message copying the "$component" service file
  cp "$component".service /etc/systemd/system/"$component".service
  status_check $?

  message "Installing Node js"
  dnf install nodejs -y
  message "Creating User roboshop"
  id roboshop &>/dev/null || useradd roboshop
  mkdir /app
  message Downloading "$component" Artifacts
  curl -o /tmp/"$component".zip https://roboshop-artifacts.s3.amazonaws.com/"$component"-v3.zip
  cd /app
  unzip /tmp/"$component".zip

  message "Installing Dependencies"
  cd /app
  npm install
}