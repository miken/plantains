class CreateEvents < ActiveRecord::Migration[5.0]
  def change
    create_table :events do |t|
      t.string :name
      t.text :description
      t.string :code
      t.integer :award_points

      t.timestamps
    end
  end
end
