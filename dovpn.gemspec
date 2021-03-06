# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dovpn/version'

Gem::Specification.new do |spec|
  spec.name          = "dovpn"
  spec.version       = Dovpn::VERSION
  spec.authors       = ["Uwe Kleinmann"]
  spec.email         = ["uwe@kleinmann.org"]

  spec.summary       = %q{Set up an OpenVPN server on DigitalOcean on demand.}
  spec.homepage      = "https://github.com/kleinmann/dovpn"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "commander", "~> 4.4.0"
  spec.add_dependency "droplet_kit", "~> 1.3.3"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
  spec.add_development_dependency "pry", "~> 0.10.3"
end
