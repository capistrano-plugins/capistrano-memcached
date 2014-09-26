# Capistrano::UnicornNginx

Capistrano tasks for automatic and memcached configuraion.

Goals of this plugin:

* automatic memcached configuration for Rails apps
* **no manual ssh** to the server required

Specifics:

* generates config file on the server (default in /etc/memcached.conf)
* generates a memcached.yml config file in shared/config for easy consumption by a RoR app
* capistrano tasks for management, example: `memcached:restart`<br/>
see below for all available tasks

`capistrano-memcached` works only with Capistrano 3!

This project was heavily inspired (i.e. copied and reworked) by 
[capistrano-nginx-unicorn](https://github.com/bruno-/capistrano-nginx-unicorn).

### Installation

Add this to `Gemfile`:

    group :development do
      gem 'capistrano', '~> 3.1'
      gem 'capistrano-memcached', '~> 1.0'
    end

And then:

    $ bundle install

### Setup and usage

Add this line to `Capfile`

    require 'capistrano/memcached'

**Setup task**

Make sure the `deploy_to` path exists and has the right privileges on the
server (i.e. `/var/www/myapp`).<br/>
Or just install
[capistrano-safe-deploy-to](https://github.com/bruno-/capistrano-safe-deploy-to)
plugin and don't think about it.

To setup the memcached server run:

    $ bundle exec cap production setup

### Configuration

As described in the Usage section, this plugin works with minimal setup.
However, configuration is possible.

You'll find the options and their defaults below.

In order to override the default, put the option in the stage file, for example:

    # in config/deploy/production.rb
    set :memcached_listen_port, 11212

Defaults are listed near option name in the first line.

* `set :memcached_memory_limit` # defaults to 128<br/>
The memory limit of memcached in MB.

* `set :memcached_log_file, "/var/log/memcached.log"`<br/>
Location of memcached log file.

* `set :memcached_port, "11211"`<br/>
The port memcached listens on.

* `set :memcached_ip, "127.0.0.1" # default listen only on localhost (for security) `<br/>
The IP memcached listens on.

* `set :memcached_roles, [:app]`<br/>
The roles on which memcached will be installed. `memcached.yml` will be available to all :app roles.

* `set :memcached_user, "memcache"`<br/>
The user account used by memcached.


### Template customization

If you want to change default templates, you can generate them using
`rails generator`:

    $ bundle exec rails g capistrano:memcached:config

This will copy default templates to `config/deploy/templates` directory, so you
can customize them as you like, and capistrano tasks will use this templates
instead of default.

You can also provide path, where to generate templates:

    $ bundle exec rails g capistrano:memcached:config config/templates

    
### TODO
* SASL authentication setup for memcached when running on multiple servers. 
    
### More Capistrano automation?

If you'd like to streamline your Capistrano deploys, you might want to check
these zero-configuration, plug-n-play plugins:

- [capistrano-unicorn-nginx](https://github.com/bruno-/capistrano-unicorn-nginx)<br/>
no-configuration unicorn and nginx setup with sensible defaults
- [capistrano-postgresql](https://github.com/bruno-/capistrano-postgresql)<br/>
plugin that automates postgresql configuration and setup
- [capistrano-rbenv-install](https://github.com/bruno-/capistrano-rbenv-install)<br/>
would you like Capistrano to install rubies for you?
- [capistrano-safe-deploy-to](https://github.com/bruno-/capistrano-safe-deploy-to)<br/>
if you're annoyed that Capistrano does **not** create a deployment path for the
app on the server (default `/var/www/myapp`), this is what you need!

### Bug reports and pull requests

...are very welcome!

### Thanks

[@bruno-](https://github.com/bruno-) - for his
[capistrano-unicorn-nginx](https://github.com/bruno-/capistrano-unicorn-nginx) plugin on which this
one is heavily based.
