ENV['RAILS_ENV'] = 'test'

require 'simplecov'
SimpleCov.start do
  skip '/test/'
  # Named rather than left to whatever got loaded: a file nothing exercises is the point
  cover '{app,lib}/**/*.rb'
  # Read by the gemspec, which Bundler evaluates before this line runs, and it holds a constant
  skip 'lib/usa/version.rb'
end
SimpleCov.minimum_coverage 100

require_relative 'dummy/config/environment'

# So that loading the schema records this gem's migrations as run rather than as pending.
ActiveRecord::Migrator.migrations_paths = [ File.expand_path('../db/migrate', __dir__) ]

require 'rails/test_help'
