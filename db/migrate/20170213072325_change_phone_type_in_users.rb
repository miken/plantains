class ChangePhoneTypeInUsers < ActiveRecord::Migration[5.0]
  def self.up
    change_column :users, :phone, :string
  end
 
  def self.down
    change_column :users, :phone, 'integer USING CAST(phone AS integer)'
  end
end
