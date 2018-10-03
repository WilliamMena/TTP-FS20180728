class OwnedStock < ApplicationRecord
  belongs_to :user
  belongs_to :stock

  def buy(amount)
    self.amount += amount
    if self.save
      return true
    else
      return false
    end
  end

end
