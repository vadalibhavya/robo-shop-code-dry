source common.sh
component=catalogue
node_setup
dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.doubtfree.online </app/db/master-data.js
