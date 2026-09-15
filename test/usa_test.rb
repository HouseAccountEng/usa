require 'test_helper'

# What seeding leaves behind, asked of the wiring rather than of the rows: which row the CSVs
# happen to hold is data, and data exercises no code of ours.
class USATest < ActiveSupport::TestCase
  test 'seeding writes every row once, joined up and counted, and a second seed changes none' do
    ours = USA::State.create! code: 'NY', fips: '36', name: 'New York'
    USA.seed
    counted = counts

    assert_equal USA::ZIP.count, USA::ZIP.joins(county: :state).count
    assert_equal USA::City.count, USA::City.joins(:counties).distinct.count
    assert_equal USA::County.count, USA::State.sum(:counties_count)
    assert_equal USA::ZIP.count, USA::County.sum(:zips_count)
    assert_equal ours.id, USA::State.find_by(code: 'NY').id

    assert_no_changes -> { USA::County.maximum :updated_at } do
      USA.seed
    end
    assert_equal counted, counts
  end

  test 'the acronyms this gem registers name its tables, its classes and its headings' do
    assert_equal 'usa_zips', USA::ZIP.table_name
    assert_equal 'ZIP', USA::ZIP.model_name.human
    assert_equal 'FIPS', USA::County.human_attribute_name(:fips)
    assert_equal 'sqlite3', USA::Record.connection_db_config.adapter
  end

  test 'a model answers by the word a host means, whatever the table underneath is called' do
    zip = USA::ZIP.model_name
    assert_equal %w[zip zips zip], [ zip.param_key, zip.route_key, zip.element ]
    assert_equal :zip, zip.i18n_key

    assert_equal %w[state county city], [ USA::State, USA::County, USA::City ].
      map { |model| model.model_name.param_key }
  end

private

  def counts
    [ USA::State, USA::County, USA::City, USA::CityCounty, USA::ZIP ].map(&:count)
  end
end
