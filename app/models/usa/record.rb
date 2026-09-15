# What every record this gem holds descends from, so a host says in one line how they connect.
class USA::Record < ActiveRecord::Base
  self.abstract_class = true
end

ActiveSupport.run_load_hooks :usa_record, USA::Record
