echo '\n\nupdating apt-get sources and installing some packages:\n\n'

apt-get update
apt-get install -y git curl libpq-dev postgresql

echo '\n\ninstalling RVM/ruby/rubygems/rails:\n\n'

\curl -sSL https://get.rvm.io | bash 
source ~/.rvm/scripts/rvm
rvm requirements
rvm install ruby-2.2.2
gem install bundler rails --no-ri --no-rdoc

echo '\n\ninstalling/configuring Postgres:\n\n'

bundle install
/etc/init.d/postgresql start
-u postgres createuser -P -s -e cpb_admin
cp config/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf

echo '\n\ncreating/seeding database:\n\n'

bundle exec rake db:create
bundle exec rake db:migrate
bundle exec rake db:test:prepare
bundle exec rake db:seed

