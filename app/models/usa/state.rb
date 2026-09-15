# A state of the United States, or the District of Columbia.
class USA::State < USA::Record
  include USA::Seeded

  has_many :counties, dependent: :destroy
  has_many :cities, dependent: :destroy

  validates :code, presence: true, length: { is: 2 }, uniqueness: true
  validates :fips, presence: true, length: { is: 2 }, uniqueness: true
  validates :name, presence: true, uniqueness: true

  # How many counties a state holds, asked of the rows: an upsert runs no callback to keep it.
  COUNTIES = 'SELECT COUNT(*) FROM usa_counties WHERE usa_counties.state_id = usa_states.id'

  # Counts the counties of every state the count is wrong for, and touches none of the others.
  # @return [void]
  def self.recount_counties
    where("counties_count <> (#{COUNTIES})").
      update_all [ "counties_count = (#{COUNTIES}), updated_at = ?", Time.current ]
  end

  # @return [String] the default representation (used in views).
  def to_s = name

  class << self
  private

    def natural_key = :code

    def seeds
      csv('states').lazy.map do |row|
        { code: row['code'], fips: row['fips'], name: row['name'],
          google_place_id: row['google_place_id'], }
      end
    end
  end
end

ActiveSupport.run_load_hooks :usa_state, USA::State
