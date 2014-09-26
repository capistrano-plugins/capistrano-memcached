module Capistrano
  module DSL
    module MemcachedPaths

      def memcached_config_file
        "/etc/memcached.conf"
      end

      def memcached_default_app_config_file
        shared_path.join('config/memcached.yml')
      end
    end
  end
end
