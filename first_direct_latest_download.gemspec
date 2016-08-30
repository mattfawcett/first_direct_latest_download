# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'first_direct_latest_download/version'

Gem::Specification.new do |spec|
  spec.name          = "first_direct_latest_download"
  spec.version       = FirstDirectLatestDownload::VERSION
  spec.authors       = ["Matt Fawcett"]
  spec.email         = ["mail@matthewfawcett.co.uk"]

  spec.summary       = %q{Download latest First Direct transactions as CSV}
  spec.description   = %q{Download latest First Direct transactions as CSV}
  spec.homepage      = "https://github.com/mattfawcett/first_direct_latest_download"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.cert_chain  = ['certs/mattfawcett.pem']
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  spec.add_dependency "selenium-webdriver", "~> 2.53"

  spec.add_development_dependency "bundler", "~> 1.12"
  spec.add_development_dependency "rake", "~> 10.0"
end
