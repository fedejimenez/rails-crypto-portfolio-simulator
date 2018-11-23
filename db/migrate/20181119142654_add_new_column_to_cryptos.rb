class AddNewColumnToCryptos < ActiveRecord::Migration[5.2]
  def change
  	 add_column :cryptos, :name, :string
  end
end
