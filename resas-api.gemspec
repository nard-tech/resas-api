# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'resas/api/version'

Gem::Specification.new do |spec|
  spec.name = 'resas-api'
  spec.version = Resas::Api::VERSION
  spec.authors = [ 'Shu Fujita' ]
  spec.email = [ 's.fujita@nard.tech' ]

  spec.summary = 'Ruby Gem for RESAS (Regional Economy Society Analyzing System) API by Japanese government.'
  spec.description = 'RESAS (Regional Economy Society Analyzing System) is developed by Japanese government. (https://resas.go.jp/) This gem enables you to access to API more easily.'
  spec.homepage = 'https://github.com/nard-tech/resas-api'
  spec.license = 'MIT'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end
  unless spec.respond_to?(:metadata)
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = [ 'lib' ]

  spec.add_runtime_dependency 'activesupport', '>= 4.2.7.1'

  spec.add_runtime_dependency 'nard-appi', '>= 0.2.0'
  spec.add_runtime_dependency 'faraday', '= 0.10'
  spec.add_runtime_dependency 'faraday_middleware', '= 0.10.1'

  spec.add_development_dependency 'bundler', '~> 1.13'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'pry'
end
