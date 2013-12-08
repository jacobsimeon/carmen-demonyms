# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'carmen/demonyms/version'

Gem::Specification.new do |spec|
  spec.name          = "carmen-demonyms"
  spec.version       = Carmen::Demonyms::VERSION
  spec.authors       = ["Jacob Morris"]
  spec.email         = ["jacob@creativesoapbox.com"]
  spec.description   = %q{Add demonyms to Carmen::Country}
  spec.summary       = %q{Add demonums to Carmen::Country}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'carmen'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "nokogiri"
end
