# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'check_mobi/version'

Gem::Specification.new do |spec|
  spec.name          = "check_mobi"
  spec.version       = CheckMobi::VERSION
  spec.authors       = ["Md. Mazharul Islam Mithu"]
  spec.email         = ["mazharul.freelancer@gmail.com"]
  spec.summary       = "sample gem"
  # spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.required_ruby_version = '>= 2.4.0'

  spec.add_development_dependency "bundler", ">= 2.2.33"
  spec.add_development_dependency "rake", ">= 12.3.3"
  spec.add_development_dependency "minitest", "~> 5.8.4"
  spec.add_development_dependency "guard"
  spec.add_development_dependency "guard-minitest"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency 'libnotify'
  spec.add_development_dependency 'minitest-focus'
  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'vcr'
end
