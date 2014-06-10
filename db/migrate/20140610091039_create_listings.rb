class CreateListings < ActiveRecord::Migration
  def self.up
    create_table :listings do |t|
      t.string :name
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :listings
  end
end
