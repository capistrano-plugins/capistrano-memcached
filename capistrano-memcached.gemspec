# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/memcached/version'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-memcached"
  gem.version       = Capistrano::Memcached::VERSION
  gem.authors       = ["Ruben Stranders"]
  gem.email         = ["r.stranders@gmail.com"]
  gem.description   = <<-EOF.gsub(/^\s+/, '')
    Capistrano tasks for automatic and sensible memcached configuration.

    Enables zero downtime deployments of Rails applications. Configs can be
    copied to the application using generators and easily customized.

    Works *only* with Capistrano 3+.

    Heavily inspired (i.e. copied and reworked) by https://github.com/bruno-/capistrano-unicorn-nginx
  EOF
  gem.summary       = "Capistrano tasks for automatic and sensible memcached configuration."
  gem.homepage      = "https://github.com/rhomeister/capistrano-memcached"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "capistrano", ">= 3.1"
  gem.add_dependency "sshkit", ">= 1.2.0"

  gem.add_development_dependency "rake"
end
