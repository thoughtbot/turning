# -*- encoding: utf-8 -*-
require File.expand_path('../lib/turning/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Joe Ferris"]
  gem.email         = ["jferris@thoughtbot.com"]
  gem.description   = %q{The wheels in the sky keep on turning}
  gem.summary       = %q{Wheels keep on spinning round, spinning round, spinning round}

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "turning"
  gem.require_paths = ["lib"]
  gem.version       = Turning::VERSION

  gem.add_dependency 'activemodel'
  gem.add_dependency 'actionpack'
  gem.add_dependency 'railties'

  gem.add_development_dependency 'rspec'
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'bourne'
  gem.add_development_dependency 'tzinfo'
  gem.add_development_dependency 'rack-test'
end
