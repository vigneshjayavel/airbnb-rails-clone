class SimplifyUserModel < ActiveRecord::Migration
  def self.up

  	drop_table :users

    create_table :users do |t|
      t.string :name,	:null=>false, :default=>''
      t.string :email,  :null=>false
      t.string :crypted_password,	:null=>false
      t.string :password_salt,	:null=>false
      t.string :persistence_token,	:null=>false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
