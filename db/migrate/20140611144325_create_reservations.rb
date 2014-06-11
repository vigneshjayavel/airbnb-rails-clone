class CreateReservations < ActiveRecord::Migration
  def self.up
    create_table :reservations do |t|
      t.integer :user_id
      t.integer :listing_id
      t.integer :guests_count

      t.timestamps
    end
  end

  def self.down
    drop_table :reservations
  end
end
