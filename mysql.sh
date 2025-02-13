source common.sh
component=mysqld

dnf install mysql-server -y
systemd_setup
mysql_secure_installation --set-root-pass RoboShop@1