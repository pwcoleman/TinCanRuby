# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tin_can_api/version'

Gem::Specification.new do |spec|
  spec.name          = "tin_can_api"
  spec.version       = TinCanApi::VERSION
  spec.authors       = ["Paul Coleman"]
  spec.email         = ["pcoleman@coleman.co.uk"]
  spec.summary       = "A Ruby library for implementing Tin Can API."
  spec.description   = %q{A Ruby library for interacting with a Learning Record Store (LRS) using the Tin Can API (Experience API)}
  spec.homepage      = 'https://github.com/pwcoleman/TinCanRuby'
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'pry', '~> 0.10'
  spec.add_development_dependency 'webmock', '~> 1.20'

  spec.add_runtime_dependency 'faraday', '~> 0.9'
  spec.add_runtime_dependency 'addressable', '~> 2.3'
  spec.add_runtime_dependency 'ruby-duration', '~> 3.2'
end
