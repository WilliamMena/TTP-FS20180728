class OwnedStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  # def buy(symbol, amount)
  #   stock =
  # end

end
