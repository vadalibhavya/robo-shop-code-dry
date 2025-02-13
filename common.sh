systemd_setup() {
  systemctl daemon-reload
  systemctl enable $component
  systemctl start $component
}

