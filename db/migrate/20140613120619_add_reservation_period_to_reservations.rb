class AddReservationPeriodToReservations < ActiveRecord::Migration
  def self.up
    add_column :reservations, :check_in, :date, :null=>false
    add_column :reservations, :check_out, :date, :null=>false
  end

  def self.down
    remove_column :reservations, :check_out
    remove_column :reservations, :check_in
  end
end
