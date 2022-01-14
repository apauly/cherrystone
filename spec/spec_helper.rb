# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:development)

require 'active_support'
require 'zeitwerk'

require 'simplecov'
require 'simplecov-lcov'
SimpleCov::Formatter::LcovFormatter.config.report_with_single_file = true
SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::LcovFormatter
])

SimpleCov.start do
  add_filter(/lib\/.*\/version\.rb$/)
  track_files '{lib,app}/**/*.rb'
end

require 'cherrystone'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  # Autoload potential fixtures/helpers
  config.before(:suite) do
    loader = Zeitwerk::Loader.new
    Dir['./spec/support/*'].each do |dir|
      loader.push_dir(dir) if File.directory?(dir)
    end
    loader.setup
  end
end
