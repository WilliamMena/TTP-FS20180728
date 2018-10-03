class CreatePortfolio < ActiveRecord::Migration[5.1]
  def change
    create_table :portfolios do |t|
      t.references :user
      t.decimal :amount
      t.references :stock
    end
  end
end
