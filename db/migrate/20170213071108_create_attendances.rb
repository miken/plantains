class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_join_table :events, :users, table_name: :attendances do |t|
      t.integer :points_awarded
      t.timestamps
    end
  end
end
