class CreateTickerSymbols < ActiveRecord::Migration[5.1]
  def change
    create_table :ticker_symbols do |t|
      t.decimal :current_value

      t.timestamps
    end
  end
end
