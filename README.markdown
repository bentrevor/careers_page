## Local setup

I spent a while trying to put together a vagrant project, and my fruitless efforts are on the
`vagrant` branch.  So here's how to set it up on OSX, assuming the repo has been cloned and you are
in the project root:

#### Run bundler:

```
    bundle install
```    

If `bundle` fails to install `pg` (and `gem install pg` also doesn't work), it means Postgres
needs to be installed and the Postgres server needs to be started.  Installing Postgres will depend
on your package manager, but here's how to do it with Homebrew:

```
    brew update && brew install postgresql
```

and to start the Postgres server:

```
    pg_ctl -D /usr/local/var/postgres start
```
    
#### Create the database user:

```
    sudo createuser -P -s -e cpb_admin
```

#### Create/migrate the databases:

```
    bundle exec rake app:setup
```
    
###### Run tests

    bundle exec rspec

###### Local server with dummy data

    bundle exec rake db:seed
    bundle exec rails s

