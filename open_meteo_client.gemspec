# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'open_meteo_client/version'

Gem::Specification.new do |spec|
  spec.name          = "open_meteo_client"
  spec.version       = OpenMeteoClient::VERSION
  spec.authors       = ["jeanbaptistevilain"]
  spec.email         = ["jbvilain@gmail.com"]
  spec.description   = "Open Meteo Forecasts client gem"
  spec.summary       = "A basic model implementation to enable open meteo forecasts data usage in RoR projects"
  spec.homepage      = "https://github.com/jeanbaptistevilain/open_meteo_client"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.0"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit"
  spec.add_development_dependency "shoulda"
  spec.add_runtime_dependency "rails", "~> 3.2.14"
  spec.add_runtime_dependency "json"
end
