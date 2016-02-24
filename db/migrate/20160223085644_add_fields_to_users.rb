class AddFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :title, :string
    add_column :users, :desc, :text
    add_column :users, :work_since, :datetime
  end
end
