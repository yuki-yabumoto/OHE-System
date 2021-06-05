#/bin/bash

/apps/ohe/bin/bundle install

/etc/init.d/mysql start

echo "CREATE USER 'user'@'%' identified by 'password';" | mysql -u root --skip-password
echo "GRANT ALL PRIVILEGES ON *.* TO 'user'@'%';" | mysql -u root --skip-password
echo "FLUSH PRIVILEGES;" | mysql -u root --skip-password

cd /apps/ohe
bin/rails db:create
bin/rails db:migrate
bin/rails db:seed

tail -f /dev/null