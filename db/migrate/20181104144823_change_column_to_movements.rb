class ChangeColumnToMovements < ActiveRecord::Migration[5.2]
  def change
  	remove_column :movements, :quantity

  	add_column :movements, :quantity, :decimal
  end
end