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
  ] + Dir.glob('lib/**/*')
  s.require_paths = ['lib']
  # http 6.0 and commonmarker 2.x both require ruby >= 3.2
  s.required_ruby_version = '>= 3.2'
  s.add_dependency 'http', '>= 5.0', '< 7.0'
  s.add_dependency 'commonmarker', '>= 2.0', '< 3.0'
  s.add_dependency 'i18n', '>= 1.8'
  # Both are required by lib/klaro/client.rb. `ostruct` stops being a default
  # gem in Ruby 3.5, so it has to be declared explicitly.
  s.add_dependency 'path', '>= 2.1', '< 3.0'
  s.add_dependency 'ostruct', '>= 0.5'
  s.add_development_dependency 'dotenv', '>= 2.7', '< 4.0'
  s.add_development_dependency 'rake', '~> 13.0'
  s.add_development_dependency 'rspec', '~> 3.8'
  s.add_development_dependency 'webmock', '~> 3.7'
end
