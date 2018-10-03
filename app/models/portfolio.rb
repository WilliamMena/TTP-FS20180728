class Portfolio < ApplicationRecord
  belongs_to :user
  has_many :stocks

  # def update(stockId, amount)
  #
  # end

end
