class Stock < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions
  has_many :owned_stocks, through: :users

  def self.supported?(ticker_symbol)
    url = "https://api.iextrading.com/1.0/stock/#{ticker_symbol}/quote"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    if response == "Unknown symbol"
      return false
    else
      return true
    end
  end

  def self.current_value(ticker_symbol)
    url = "https://api.iextrading.com/1.0/stock/#{ticker_symbol}/quote"
    uri = URI(url)
    response = Net::HTTP.get(uri)
    data = JSON.parse(response)
    return data["latestPrice"]
  end

  def update_value
    self.current_value = Stock.current_value(self.ticker_symbol)
    if self.save
      return true
    else
      return false
    end
  end
end
