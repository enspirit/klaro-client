namespace :test do
  require "rspec/core/rake_task"

  tests = []

  desc "Runs unit tests"
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.pattern = "spec/**/*_spec.rb"
    t.rspec_opts = ["-Ilib", "-Ispec", "--fail-fast", "--color", "--backtrace", "--format=progress"]
  end
  tests << :unit

  task :all => tests
end

desc "Runs all tests"
task :test => :'test:all'
