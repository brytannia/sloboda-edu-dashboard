class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :datetime
      t.string :subject
      t.boolean :confirmed
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
