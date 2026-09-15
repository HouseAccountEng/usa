class SeedUSA < ActiveRecord::Migration[8.1]
  def change
    up_only { USA.seed }
  end
end
