# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capistrano/safe_deploy_to/version'

Gem::Specification.new do |gem|
  gem.name          = "capistrano-safe-deploy-to"
  gem.version       = Capistrano::SafeDeployTo::VERSION
  gem.authors       = ["Bruno Sutic"]
  gem.email         = ["bruno.sutic@gmail.com"]
  gem.description   = "Capistrano plugin that ensures the `deploy_to` deployment path exists and has the right permissions."
  gem.summary       = "Capistrano plugin that ensures the `deploy_to` deployment path exists and has the right permissions."
  gem.homepage      = "https://github.com/bruno-/capistrano-safe-deploy-to"

  gem.license       = "MIT"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_dependency "capistrano", ">= 3.0"

  gem.add_development_dependency "rake"
end
