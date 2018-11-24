class AddNewColumnToUsers < ActiveRecord::Migration[5.2]
  def change
  	 remove_column :users, :name
  	 remove_column :users, :username

  	 add_column :users, :name, :string
  	 add_column :users, :username, :string, null: false
  	 
  	 enable_extension 'hstore' unless extension_enabled?('hstore')
  	 add_column :users, :settings, :hstore
  end
end
