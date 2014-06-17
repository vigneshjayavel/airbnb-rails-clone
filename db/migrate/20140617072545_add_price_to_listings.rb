class AddPriceToListings < ActiveRecord::Migration
  def self.up
    add_column :listings, :price, :integer, :null=>false, :default=>10000
  end

  def self.down
    remove_column :listings, :price
  end
end
