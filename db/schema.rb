# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20140618061350) do

  create_table "listings", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.date     "availability_from",                            :null => false
    t.date     "availability_to",                              :null => false
    t.integer  "notice_period",     :default => 5,             :null => false
    t.integer  "maximum_guests",    :default => 1,             :null => false
    t.string   "home_type",         :default => "house",       :null => false
    t.string   "room_type",         :default => "entire home", :null => false
    t.string   "snap_file_name"
    t.string   "snap_content_type"
    t.integer  "snap_file_size"
    t.datetime "snap_updated_at"
    t.integer  "price",             :default => 10000,         :null => false
    t.string   "place",                                        :null => false
  end

  create_table "reservations", :force => true do |t|
    t.integer  "user_id"
    t.integer  "listing_id"
    t.integer  "guests_count"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "check_in",     :null => false
    t.date     "check_out",    :null => false
  end

  create_table "user_sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "user_sessions", ["session_id"], :name => "index_user_sessions_on_session_id"
  add_index "user_sessions", ["updated_at"], :name => "index_user_sessions_on_updated_at"

  create_table "users", :force => true do |t|
    t.string   "name",              :default => "", :null => false
    t.string   "email",                             :null => false
    t.string   "crypted_password",                  :null => false
    t.string   "password_salt",                     :null => false
    t.string   "persistence_token",                 :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
