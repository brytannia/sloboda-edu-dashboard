class AddOmniauthFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :provider, :string, :null => false
    add_column :users, :uid, :string, :null=>false, :default=>""
  end
end
