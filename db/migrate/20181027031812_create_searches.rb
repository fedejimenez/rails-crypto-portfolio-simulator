class CreateSearches < ActiveRecord::Migration[5.2]
  def change
    create_table :searches do |t|
      t.string :keywords
      t.string :id_crypto
      t.string :name
      t.string :symbol
      t.string :rank
      t.string :market
      t.string :category
      t.decimal :min_price
      t.decimal :max_price
      t.decimal :volume_24h_usd
      t.string :percent_change_1h
      t.string :percent_change_24h
      t.string :percent_change_7d

      t.timestamps
    end
  end
end
