class CreateUSACities < ActiveRecord::Migration[8.1]
  def change
    create_table :usa_cities do |t|
      t.string :fips, limit: 5, null: false
      t.string :name, null: false, index: true
      t.references :state, null: false, index: false, foreign_key: { to_table: :usa_states }
      t.string :google_place_id
      t.timestamps
      t.index %i[state_id fips], unique: true
    end
  end
end
