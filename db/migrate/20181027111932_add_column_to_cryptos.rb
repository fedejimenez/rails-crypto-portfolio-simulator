class AddColumnToCryptos < ActiveRecord::Migration[5.2]
  def change
  	add_column :cryptos, :portfolio_id, :integer
  end
end
