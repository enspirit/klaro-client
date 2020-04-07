# frozen_string_literal: true
$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))
require 'date'
require 'klaro/client/version'

Gem::Specification.new do |s|
  s.name = 'klaro-client'
  s.author = 'enspirit'
  s.version = Klaro::Client::VERSION
  s.date = Date.today.to_s
  s.summary = 'Klaro Client'
  s.license = 'MIT'
  s.files = [
    'Gemfile',
    'Rakefile',
    'VERSION',
  ] + Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  s.add_dependency 'dotenv', '~> 2.7'
  s.add_dependency 'http', '~> 4.2'
  s.add_dependency 'redcarpet', '~> 3.0', '>= 3.4'
  s.add_dependency 'i18n', '>= 1.8'
  s.add_development_dependency 'path', '~> 2.0'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'webmock', '~> 3.7'
end
