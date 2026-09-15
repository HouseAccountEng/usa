# What every table this gem ships knows how to do: write its own rows, twice over if asked.
module USA::Seeded extend ActiveSupport::Concern
  # Rows per statement. An upsert inlines its values rather than binding them, so this bounds
  # how long one statement runs and how many rows are held at once, not a placeholder count.
  SLICE = 1000

  class_methods do
    # Writes the rows this release holds that are missing, and the columns of the rest.
    # @return [void]
    def seed
      seeds.each_slice(SLICE) do |slice|
        upsert_all slice, unique_by: natural_key, record_timestamps: true
      end
    end

  private

    def csv(name)
      CSV.foreach USA::Engine.root.join("db/seeds/#{name}.csv"), headers: true
    end
  end
end
