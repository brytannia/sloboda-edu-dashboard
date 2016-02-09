class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.timestamp :datetime
      t.string :subject
      t.boolean :confirmed
      t.integer :location_id

      t.timestamps null: false
    end
  end
end
