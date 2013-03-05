class Quote < ActiveRecord::Base
  attr_accessible :cell, :email, :quote_number, :name
  has_one :appointment
end
