source 'https://rubygems.org'

# Specify your gem's dependencies in usa.gemspec.
gemspec

gem 'debug' # to break into a test that fails
gem 'irb' # bin/console has no REPL to start without it
gem 'minitest' # the suite has no framework to run in without it
gem 'rake' # CI has no default task to run without it
gem 'rubocop-rails-omakase', require: false # the linter has no house style without it
gem 'simplecov', require: false # a line going untested fails nothing without it
gem 'sqlite3' # the dummy app has no database to migrate without it
