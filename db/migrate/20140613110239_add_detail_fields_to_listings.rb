class AddDetailFieldsToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :availability_from, :date, :null=>false
    add_column :listings, :availability_to, :date, :null=>false
    add_column :listings, :notice_period, :integer, :null=>false, :default=>5
    add_column :listings, :maximum_guests, :integer, :null=>false, :default=>1
    add_column :listings, :home_type, :string, :null=>false, :default=>'house'
    add_column :listings, :room_type, :string, :null=>false, :default=>'entire home'
  end

  def self.down
    remove_column :listings, :type
    remove_column :listings, :maximum_guests
    remove_column :listings, :notice_period
    remove_column :listings, :availability_to
    remove_column :listings, :availability_from
  end
end
