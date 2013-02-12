# -*- encoding: utf-8 -*-

Gem::Specification.new do |gem|
  gem.authors       = ["Josh Ferguson", "Justin Berka"]
  gem.email         = ["playboy@yammer-inc.com", "jberka@yammer-inc.com"]
  gem.description   = %q{An ActiveRecord adapter for Vertica}
  gem.summary       = %q{An ActiveRecord adapter for Vertica}
  gem.homepage      = "http://github.com/yammer/activerecord-vertica-adapter"

  gem.files         = ['activerecord-vertica-adapter.gemspec', 
                      'README.md',
                      'Rakefile',
                      'lib/activerecord-vertica-adapter.rb',
                      'lib/active_record/connection_adapters/vertica_adapter.rb'
                      ]
  gem.name          = "activerecord-vertica-adapter"
  gem.require_paths = ["lib"]
  gem.version       = "0.1.0"

  gem.add_dependency 'vertica', '>= 0.9.4'
end
