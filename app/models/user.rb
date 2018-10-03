class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :email, uniqueness: true

  has_many :transactions
  has_many :stocks, through: :transactions
  has_many :owned_stocks

  def buy(symbol, amount)
    if !Stock.supported?(symbol)
      puts "We don't support this stock"
      return false
    else
      stock = Stock.find_or_create_by(ticker_symbol: symbol)
      stock.update_value
    end

    if (stock.current_value * amount) <= self.cash
      self.transactions.create(stock: stock, value_of_each: stock.current_value, number_of_shares: amount)
      owned_stock = OwnedStock.find_by({user: self, stock_id: stock})
      if owned_stock
        owned_stock.buy(amount)
      else
        owned_stock = OwnedStock.create({user: self, stock: stock, amount: amount})
      end
      self.cash = self.cash - (stock.current_value * amount)
      self.save
      puts "Bought some stock"
    else
      puts "You don't have enough money for this amount"
      return false
    end

    return true
  end

  def portfolio_value
    amount = 0
    self.owned_stocks.each do |s|
      amount += s.stock.current_value * s.amount
    end
    return ActionController::Base.helpers.number_to_currency(amount)
  end

end
