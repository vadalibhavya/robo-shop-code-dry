dnf install maven -y
cp shipping.service /etc/systemd/system/shipping.service
useradd roboshop
mkdir /app
curl -o /tmp/shipping.zip https://roboshop-artifacts.s3.amazonaws.com/shipping-v3.zip
cd /app
unzip /tmp/shipping.zip
cd /app
mvn clean package
mv target/shipping-1.0.jar shipping.jar

systemctl daemon-reload
systemctl enable shipping
systemctl start shipping
dnf install mysql -y


for file in schema aap-user master-data;
do
  message "loading $file"
  mysql -h mysql-dev.doubtfree.online -uroot -pRoboShop@1 < /app/db/$file.sql
done
systemctl restart shipping

