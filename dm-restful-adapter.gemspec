# -*- encoding: utf-8 -*-
require File.expand_path('../lib/dm-restful-adapter/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Ryan Moran", "Hubert Huang"]
  gem.email         = ["ryan.moran@gmail.com", "hubert77@gmail.com"]
  gem.description   = 'Modular adapter for datamapper to access remote resources restfully'
  gem.summary       = ''
  gem.homepage      = "https://github.com/optimis/dm-restful-adapter"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "dm-restful-adapter"
  gem.require_paths = ["lib"]
  gem.version       = DataMapper::Adapters::RestfulAdapter::VERSION

  gem.add_dependency 'dm-core', '1.2.1'
  gem.add_dependency 'multi_json'
  gem.add_development_dependency 'rspec', '~> 2.9.0'
  gem.add_development_dependency 'mimic', '~> 0.4.3'
  gem.add_development_dependency 'activerecord'
  gem.add_development_dependency 'sqlite3'
  gem.add_development_dependency 'database_cleaner'
end
