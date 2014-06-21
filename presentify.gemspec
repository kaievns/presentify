# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'presentify/version'

Gem::Specification.new do |spec|
  spec.name          = "presentify"
  spec.version       = Presentify::VERSION
  spec.authors       = ["Nikolay Nemshilov"]
  spec.email         = ["nemshilov@gmail.com"]
  spec.summary       = %q{Turns a folder with ruby files into a CLI presentation.}
  spec.description   = %q{Turns a folder with ruby files into a CLI presentation. For real.}
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
