class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :firstname, :string
    add_column :users, :lastname, :string
    add_column :users, :verification, :boolean
    add_column :users, :role, :string, default: "user"
    add_column :users, :avatar, :string
  end
end
