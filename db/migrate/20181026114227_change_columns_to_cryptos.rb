class ChangeColumnsToCryptos < ActiveRecord::Migration[5.2]
  def change
  	remove_column :cryptos, :amount_owned

  	add_column :cryptos, :amount_owned, :decimal
  	add_column :cryptos, :last_transaction, :decimal, value: 0
  end
end