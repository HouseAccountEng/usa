require 'action_dispatch'
require 'rails/engine'

module USA
  # Teaches Rails where this gem's models live, and prefixes their tables with `usa_`.
  class Engine < ::Rails::Engine
    isolate_namespace USA
  end
end
