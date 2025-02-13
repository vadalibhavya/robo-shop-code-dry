source common.sh
component=mongobd
cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y

#update listen address from 127.0.0.1 to 0.0.0.0 in /etc/mongod.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf

systemd_setup
