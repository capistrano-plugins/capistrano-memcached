require 'capistrano/dsl/memcached_paths'
require 'capistrano/memcached/helpers'

include Capistrano::Memcached::Helpers
include Capistrano::DSL::MemcachedPaths

namespace :load do
  task :defaults do
    set :memcached_memory_limit, 128
    set :memcached_log_file, "/var/log/memcached.log"
    set :memcached_port, 11211
    set :memcached_ip, "127.0.0.1" # listen only on localhost (for security)

    # this is where memcached will be installed. A handy memcached.yml file will be created on all :app roles in
    # shared/config
    set :memcached_roles, [:app]
    set :memcached_user, "memcache"

    set :memcached_app_config, -> { memcached_default_app_config_file }

  end
end

namespace :memcached do

  desc "Setup Memcached config file"
  task :setup do
    on roles fetch(:memcached_roles) do
      sudo "useradd #{fetch(:memcached_user)}; true" # create user, but don't fail if it already exists
      sudo "apt-get", "-y install memcached"

      sudo_upload! mem_template("memcached.erb"), memcached_config_file
      invoke "memcached:restart"
    end
  end

  desc 'Setup Memcached app configuration'
  task :setup_app_config do
    on roles :app do
      execute :mkdir, '-pv', File.dirname(fetch(:memcached_app_config))
      upload! mem_template('memcached.yml.erb'), fetch(:memcached_app_config)
    end
  end

  task :memcached_yml_symlink do
    on roles :app do
      set :linked_files, fetch(:linked_files, []).push("config/memcached.yml")
    end
  end

  before 'deploy:symlink:linked_files', 'memcached:memcached_yml_symlink'

  %w[start stop restart].each do |command|
    desc "#{command} Memcached"
    task command do
      on roles fetch(:memcached_roles) do
        sudo :service, "memcached #{command}"
      end
    end
  end
end

desc 'Server setup tasks'
task :setup do
  invoke 'memcached:setup'
  invoke 'memcached:setup_app_config'
end