require 'rails/generators/active_record'

module USA
  module Generators
    # Everything installing this gem writes into a host: the migrations that make its tables
    # and fill them. Not an initializer, because there is nothing here to configure.
    class InstallGenerator < Rails::Generators::Base
      include ActiveRecord::Generators::Migration

      # Thor reads `USA` as `u_s_a` rather than underscoring it, so the name somebody types is
      # said here. Without this line `bin/rails g usa:install` finds no generator at all.
      namespace 'usa:install'

      # @return [Array<String>] where a file being copied is looked for.
      def self.source_paths = [ USA::Engine.root.join('db/migrate').to_s ]

      # Copied rather than read off the gem, so the host owns the files and their timestamps.
      # @return [void]
      def copy_migrations
        Dir.children(USA::Engine.root.join('db/migrate')).sort.each do |name|
          migration_template name, "db/migrate/#{name.split('_', 2).last}"
        end
      end
    end
  end
end
