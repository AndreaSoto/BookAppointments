# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130416032459) do

  create_table "appointments", :force => true do |t|
    t.integer  "quote_id"
    t.datetime "date"
    t.text     "location"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "day"
    t.string   "time"
  end

  create_table "quotes", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "cell"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "quote_number"
    t.integer  "h_feet"
    t.integer  "h_inches"
    t.integer  "l_feet"
    t.integer  "l_inches"
    t.integer  "w_feet"
    t.integer  "w_inches"
    t.integer  "ceiling"
    t.integer  "insulated"
    t.integer  "panel"
  end

end
