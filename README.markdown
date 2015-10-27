## Local setup

#### vagrant + virtualbox

This assumes Homebrew and Homebrew-Cask are installed (`brew install caskroom/cask/brew-cask`).

Clone repo:

    $ git clone git@github.com:bentrevor/careers_page.git
    $ cd careers_page

Use Homebrew-Cask to install Vagrant and Virtualbox:

    $ brew update
    $ brew cask install vagrant
    $ brew cask install virtualbox

Use vagrant to start the box and ssh into it:

    $ vagrant up
    $ vagrant ssh

Update apt-get sources and install some packages:

    $ sudo apt-get update
    $ sudo apt-get install curl libpq-dev postgresql

RVM/ruby/rubygems/rails:

    $ \curl -sSL https://get.rvm.io | bash 
    $ source ~/.rvm/scripts/rvm
    $ rvm requirements
    $ rvm install ruby-2.2.2
    $ gem install bundler rails --no-ri --no-rdoc

Install/configure Postgres:

    $ bundle install
    $ sudo /etc/init.d/postgresql start
    $ sudo -u postgres createuser -P -s -e cpb_admin
    $ sudo cp config/pg_hba.conf /etc/postgresql/9.1/main/pg_hba.conf

Create/seed database:

    $ bundle exec rake db:create
    $ bundle exec rake db:migrate
    $ bundle exec rake db:test:prepare
    $ bundle exec rake db:seed

Now you should be able to visit `localhost:8080` in the browser and use the app.

#### OSX + homebrew

Running it straight on OSX will probably Just Work (tm), but using the vm is more certain.

If `bundle` fails to install `pg` (and `gem install pg` also doesn't work), it means Postgres needs
to be installed with `brew install postgresql`.  OSX can get fussy when multiple versions of
Postgres are installed - here are the caveats listed by Homebrew:

    If builds of PostgreSQL 9 are failing and you have version 8.x installed,
    you may need to remove the previous version first. See:
    https://github.com/Homebrew/homebrew/issues/2510
    
    To migrate existing data from a previous major version (pre-9.4) of PostgreSQL, see:
    https://www.postgresql.org/docs/9.4/static/upgrading.html
    
    To have launchd start postgresql at login:
    ln -sfv /usr/local/opt/postgresql/*.plist ~/Library/LaunchAgents
    Then to load postgresql now:
    launchctl load ~/Library/LaunchAgents/homebrew.mxcl.postgresql.plist
    Or, if you don't want/need launchctl, you can just run:
    postgres -D /usr/local/var/postgres
    
    WARNING: launchctl will fail when run under tmux.
