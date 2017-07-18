# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'jd_pay/version'

Gem::Specification.new do |spec|
  spec.name          = "jdpay"
  spec.version       = JdPay::VERSION
  spec.authors       = ["Genkin He"]
  spec.email         = ["hemengzhi88@gmail.com"]
  spec.summary       = %q{An unofficial simple jdpay gem.}
  spec.description   = %q{An unofficial simple jdpay gem}
  spec.homepage      = "https://github.com/genkin-he/jd_pay"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  spec.test_files = Dir["test/**/*"]

  spec.add_runtime_dependency "rest-client", '>= 2.0.0'
  spec.add_runtime_dependency "activesupport", '>= 3.2'
  spec.add_runtime_dependency "builder", '~> 3.2.2'

  spec.add_development_dependency "bundler", '~> 1.3'
  spec.add_development_dependency "rake", '~> 11.2'
  spec.add_development_dependency "webmock", '~> 2.3'
  spec.add_development_dependency "minitest", '~> 5'
end
