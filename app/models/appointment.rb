class Appointment < ActiveRecord::Base
  attr_accessible :date, :location, :quote_id
  belongs_to :quote
end
