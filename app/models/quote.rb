class Quote < ActiveRecord::Base
  attr_accessible :cell, :email, :quote_number, :name, :h_feet, :h_inches, :w_feet, :w_inches, :l_feet, :l_inches, :ceiling, :insulated, :panel
  has_one :appointment
  validates_presence_of :email, :name, :h_feet, :h_inches
end
