class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
    	t.integer :user_id 
    	t.decimal :balance
    	t.string :last_action

      t.timestamps
    end
    add_index :portfolios, :user_id
  end
end
