source common.sh
component=catalogue
useradd
systemrestart $component
message " Installing mongodb "
dnf install mongodb-mongosh -y
mongosh --host mongodb-dev.doubtfree.online </app/db/master-data.js
