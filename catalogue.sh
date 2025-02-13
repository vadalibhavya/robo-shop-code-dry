source common.sh
component=catalogue
print_message "Installing $component"
node_setup
print_message "Installing $component"
dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.doubtfree.online </app/db/master-data.js
