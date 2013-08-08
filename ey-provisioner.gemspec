# -*- encoding: utf-8 -*-
require File.expand_path('../lib/ey-provisioner/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Dan Draper"]
  gem.email         = ["daniel@codefire.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "ey-provisioner"
  gem.require_paths = ["lib"]
  gem.version       = Ey::Provisioner::VERSION

  gem.add_dependency 'excon'
  gem.add_dependency 'json'
  gem.add_dependency 'activemodel'

  gem.add_development_dependency 'pry'
  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'mocha'
  gem.add_development_dependency 'shoulda'
  gem.add_development_dependency 'activesupport'
end
