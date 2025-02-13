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

