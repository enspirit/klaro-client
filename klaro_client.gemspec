# frozen_string_literal: true

Gem::Specification.new do |s|
  s.name = 'klaro-client'
  s.author = 'enspirit'
  s.version = '0.3.0'
  s.date = '2020-01-06'
  s.summary = 'Klaro Client'
  s.license = 'MIT'
  s.files = [
    'Gemfile',
    'Rakefile',
    'VERSION',
  ] + Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  s.add_dependency 'dotenv', '~> 2.7'
  s.add_dependency 'http', '~> 4.1'
  s.add_development_dependency 'path', '~> 2.0'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'webmock', '~> 3.7'
end
