# Where a city lies: one row per county it reaches into, since a city may span several.
class USA::CityCounty < USA::Record
  include USA::Seeded

  belongs_to :city
  belongs_to :county

  class << self
  private

    def natural_key = %i[city_id county_id]

    def seeds
      cities = USA::City.joins(:state).pluck('usa_states.code', :fips, 'usa_cities.id').
        to_h { |code, fips, id| [ [ code, fips ], id ] }
      counties = USA::County.pluck(:fips, :id).to_h
      csv('cities').lazy.flat_map do |row|
        city_id = cities.fetch [ row['state'], row['fips'] ]
        row['counties'].split.map { |fips| { city_id:, county_id: counties.fetch(fips) } }
      end
    end
  end
end
