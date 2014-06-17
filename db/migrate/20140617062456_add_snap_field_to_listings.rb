class AddSnapFieldToListings < ActiveRecord::Migration
  def self.up
  	change_table :listings do |t|
      t.has_attached_file :snap
    end
  end

  def self.down
    drop_attached_file :listings, :snap
  end
end
