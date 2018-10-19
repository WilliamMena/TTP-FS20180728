class AddTodaysOpenToStocks < ActiveRecord::Migration[5.1]
  def change
    add_column :stocks, :todays_open, :decimal
  end
end
