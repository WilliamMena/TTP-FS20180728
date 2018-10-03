class AddBoughtToTransactions < ActiveRecord::Migration[5.1]
  def change
    add_column :transactions, :bought, :boolean
  end
end
