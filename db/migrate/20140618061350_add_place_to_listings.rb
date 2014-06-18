class AddPlaceToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :place, :string, :null=>false
  end

  def self.down
    remove_column :listings, :place
  end
end
