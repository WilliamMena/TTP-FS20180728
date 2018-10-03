class ChangePortfolioToOwnedStocks < ActiveRecord::Migration[5.1]
  def change
    rename_table :portfolios, :owned_stocks
  end
end
