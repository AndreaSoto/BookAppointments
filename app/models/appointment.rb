class Appointment < ActiveRecord::Base
  attr_accessible :date, :location, :quote_id, :day, :time
  belongs_to :quote
end
