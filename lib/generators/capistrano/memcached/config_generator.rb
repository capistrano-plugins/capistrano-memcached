module Capistrano
  module Memcached
    module Generators
      class ConfigGenerator < Rails::Generators::Base
        desc "Create local memcached configuration files for customization"
        source_root File.expand_path('../templates', __FILE__)
        argument :templates_path, type: :string,
          default: "config/deploy/templates",
          banner: "path to templates"

        def copy_template
          copy_file "memcached.erb", "#{templates_path}/memcached.erb"
        end
      end
    end
  end
end
