# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'vimeo/version'

Gem::Specification.new do |spec|
  spec.name             = "vimeo"
  spec.version          = Vimeo::VERSION
  spec.authors          = ["Matt Hooks"]
  spec.description      = "A full featured Ruby implementation of the Vimeo API."
  spec.email            = "matthooks@gmail.com"
  spec.homepage         = "http://github.com/matthooks/vimeo"
  spec.rdoc_options     = ["--main", "README.rdoc", "--inline-source", "--charset = UTF-8"]
  spec.rubygems_version = "2.2.0"
  spec.summary          = spec.description

  spec.files            = `git ls-files -z`.split("\x0")
  spec.executables      = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files       = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths    = ["lib"]

  spec.add_dependency "oauth2", "~> 1.0"
  spec.add_dependency "faraday", "~> 0.9.0"
  spec.add_dependency "hashie", "~> 3.3"

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.1"
  spec.add_development_dependency "rspec-its", "~> 1.1"
  spec.add_development_dependency "rspec-mocks", "~> 3.1"
  spec.add_development_dependency "vcr", "~> 2.9"
  spec.add_development_dependency "webmock", "~> 1.20"
  spec.add_development_dependency "byebug"
end

