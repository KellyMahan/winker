# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'winker/version'

Gem::Specification.new do |spec|
  spec.name          = "winker"
  spec.version       = Winker::VERSION
  spec.authors       = ["Kelly Mahan"]
  spec.email         = ["kmahan@kmahan.com"]
  spec.summary       = %q{Winker is a gem written to support the wink api and any other associated platforms.}
  spec.description   = %q{Winker is a gem written to support the wink api and any other associated platforms.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "faraday", "~> 0.9"
  spec.add_dependency "faraday_middleware", "~> 0.9"
  spec.add_dependency "faraday-detailed_logger", "~> 1.0"
  spec.add_dependency "hashie", "~> 3.4"
  spec.add_dependency "activesupport"
  spec.add_dependency "multi_json"
end
