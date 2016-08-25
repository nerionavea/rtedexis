# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rtedexis/version'

Gem::Specification.new do |spec|
  spec.name          = "rtedexis"
  spec.version       = Rtedexis::VERSION
  spec.authors       = ["Nerio Navea"]
  spec.email         = ["neriojose5@gmail.com"]

  spec.summary       = %q{A Ruby integration for Tedexis SMS delivery}
  spec.homepage      = "https://github.com/nerionavea/rtedexis"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "test-unit"
  spec.add_dependency 'savon'
  spec.add_dependency 'net-sftp'
end
