# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lendmarket/version'

Gem::Specification.new do |spec|
  spec.name          = "lendmarket"
  spec.version       = Lendmarket::VERSION
  spec.authors       = ["Valters Krontals"]
  spec.email         = ["v.krontals@gmail.com"]
  spec.summary       = %q{Command line tool to get the best rate}
  spec.description   = %q{Yada yada yada.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = ['lendmarket']
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
end
