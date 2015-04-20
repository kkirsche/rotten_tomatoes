# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rotten_tomatoes/version'

Gem::Specification.new do |spec|
  spec.name          = "rotten_tomatoes"
  spec.version       = RottenTomatoes::VERSION
  spec.authors       = ["Kevin Kirsche"]
  spec.email         = ["Kev.Kirsche@gmail.com"]

  spec.summary       = %q{Rotten Tomatoes v1 API Wrapper.}
  spec.description   = %q{Wraps the Rotten Tomatoes v1.0 JSON API in a simple to use package.}
  spec.homepage      = "https://github.com/kkirsche/rotten_tomatoes"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.6"
  spec.add_development_dependency "codeclimate-test-reporter", "~> 0.4"
  spec.add_runtime_dependency "hurley", "~> 0.1"
end
