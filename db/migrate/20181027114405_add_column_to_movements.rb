class AddColumnToMovements < ActiveRecord::Migration[5.2]
  def change
  	 add_column :movements, :user_id, :integer
  	 add_column :movements, :portfolio_id, :integer
  end
end
