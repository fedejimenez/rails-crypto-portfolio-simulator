class CreateMovements < ActiveRecord::Migration[5.2]
  def change
    create_table :movements do |t|
      t.decimal :price
      t.datetime :date
      t.integer :quantity
      t.integer :crypto_id
      t.string :operation

      t.timestamps
    end
    add_index :movements, :crypto_id
  end
end
