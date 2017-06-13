# README

-- Development running guide

* git clone https://github.com/Dvlp3r/Fore-WEBAPP.git -b admin_portal
* bundle install
* rails db:create db:migrate
* mv config/database.yml.example config/database.yml
* rails db:create db:migrate
* rails s

-- Deployment guide

* ssh -i path_to_fore_pem/fore.pem fore@34.209.118.108
* password when requested is: fore
* cd /var/www/fore/code
* git pull
* sudo /etc/init.d/apache2 restart
