# frozen_string_literal: true

require_relative 'lib/cherrystone/version'

Gem::Specification.new do |spec|
  spec.name = 'cherrystone'
  spec.version = Cherrystone::VERSION
  spec.authors = ['alex.pauly@posteo.de']

  spec.summary = 'Cherrystone'
  spec.homepage = 'https://github.com/apauly/cherrystone'
  spec.license = 'MIT'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.6')

  spec.files = Dir['{app,config,db,lib}/**/*']
  spec.require_paths = ['lib']

  spec.add_dependency 'cherrystone_core', Cherrystone::VERSION

  spec.add_development_dependency 'amazing_print'
  spec.add_development_dependency 'byebug'

  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec-rails'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'shoulda-matchers'

  spec.add_development_dependency 'simplecov'
  spec.add_development_dependency 'simplecov-lcov'
end
