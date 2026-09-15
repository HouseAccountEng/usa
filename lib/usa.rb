require 'active_support/inflector'
require 'csv'

# Before the engine, so Zeitwerk reads usa/zip.rb as USA::ZIP and a heading says ZIP, not Zip.
ActiveSupport::Inflector.inflections do |inflect|
  inflect.acronym 'USA'
  inflect.acronym 'ZIP'
  inflect.acronym 'FIPS'
end

require 'usa/version'
require 'usa/engine'

# The geography of the United States: the states, counties, cities and ZIPs an address names.
module USA
  # Writes every row this release holds, keeping the id of every row the database already has.
  # @return [void]
  def self.seed
    [ USA::State, USA::County, USA::City, USA::CityCounty, USA::ZIP ].each(&:seed)
    USA::State.recount_counties
    USA::County.recount_zips
  end
end
