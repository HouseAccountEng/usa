require_relative 'boot'

require 'rails'
require 'active_record/railtie'

Bundler.require(*Rails.groups)

# Stands in for the app a host installs this gem into. SQLite on purpose: what it proves is
# that the seed's upserts and the two counter statements run on a second adapter, with no
# server to start -- and this app is a fixture, not something anybody deploys.
module Dummy
  class Application < Rails::Application
    config.load_defaults Rails::VERSION::STRING.to_f

    config.eager_load = false
  end
end
