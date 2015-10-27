#### Local setup

I spent a while trying to put together a vagrant project, and my fruitless efforts are on the
`vagrant` branch.  So here's how to set it up on OSX (assuming Homebrew and Homebrew-Cask are
installed, and you are in the project root):

    bundle install

If `bundle` fails to install `pg` (and `gem install pg` also doesn't work), it means Postgres needs
to be installed and the Postgres server needs to be started:

    brew update && brew install postgresql
    pg_ctl -D /usr/local/var/postgres start

Then create the database user and for the app:

    sudo createuser -P -s -e cpb_admin

Then run this rake task to set up and seed the databases:

    bundle exec rake app:setup

Now you should be able to run the tests with `bundle exec rspec`, and start the rails server with
`bundle exec rails s`.  To populate the db with dummy data, run `bundle exec rake db:seed`.

