class CreateTransactions < ActiveRecord::Migration[5.1]
  def change
    create_table :transactions do |t|
      t.references :user, foreign_key: true
      t.references :stock, foreign_key: true
      t.decimal :value_of_each
      t.decimal :number_of_shares

      t.timestamps
    end
  end
end
