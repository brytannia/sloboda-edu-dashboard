class AddCoworkerToUsers < ActiveRecord::Migration
  def change
      add_column :users, :coworker, :boolean, default: false
  end
end
