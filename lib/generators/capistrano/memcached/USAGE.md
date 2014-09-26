To create local memcached configuration files call

    bundle exec rails generate capistrano:memcached:config [path]

The default path is "config/deploy/templates". You can override it like so:

    bundle rails generate capistrano:memcached:config "config/templates"

If you override templates path, don't forget to set "templates_path" variable in your deploy.rb
