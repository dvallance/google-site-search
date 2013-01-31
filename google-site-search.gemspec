# -*- encoding: utf-8 -*-
require File.expand_path('../lib/google-site-search/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["David Vallance"]
  gem.email         = ["davevallance@gmail.com"]
  gem.description   = %q{A gem to aid in the consumption of the google site search service; querys the service, populates a result object and has some related helper methods.}
  gem.summary       = gem.description 
  gem.homepage      = "https://github.com/dvallance/google-site-search"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "google-site-search"
  gem.require_paths = ["lib"]
  gem.version       = GoogleSiteSearch::VERSION
  gem.add_dependency("activesupport")
  gem.add_dependency("libxml-ruby", ">=2.4")
  gem.add_dependency("rsmaz")
  gem.add_dependency("rack")
end
