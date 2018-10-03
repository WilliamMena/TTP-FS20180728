class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :email, uniqueness: true

  has_many :transactions
  has_many :stocks, through: :transactions
  has_one :portfolio

  def buy(symbol, amount)
    if !Stock.supported?(symbol)
      puts "We don't support this stock"
      return false
    else
      stock = Stock.find_or_create_by(ticker_symbol: symbol)
      binding.pry
    end

    if (stock.current_value * amount) <= self.cash
      self.transactions.create(stock: stock, value_of_each: stock.current_value, number_of_shares: amount)
      self.cash = self.cash - (stock.current_value * amount)
      puts "Bought some stock"
    else
      puts "You don't have enough money for this amount"
      return false
    end

    return true
  end

end
