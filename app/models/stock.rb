require 'httparty'

class Stock < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions
  has_many :owned_stocks, through: :users

  @stock_cache = {}

  def self.stock_cache
    @stock_cache
  end

  def stock_cache
    self.class.stock_cache
  end

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
    return data
  end

  def self.update_all_for_user(user_id)
    User.find(user_id).owned_stocks.each do |s|
      if !Stock.stock_cache.has_key?(s.stock.ticker_symbol.to_sym)
        puts s.stock.ticker_symbol + " Not in cache"
        s.stock.update_value
      end
    end
  end

  def update_value
    data = Stock.current_value(self.ticker_symbol)
    self.todays_open = data["open"]
    self.current_value = data["latestPrice"]
    if self.save
      insertStock(self.ticker_symbol, data["open"], data["latestPrice"])
      return true
    else
      return false
    end
  end

  def current_color
    if self.current_value > self.todays_open
      return "text-success"
    elsif self.current_value == self.todays_open
      return "text-secondary"
    elsif self.current_value < self.todays_open
      return "text-danger"
    else
      return "text-dark"
    end
  end
end

private

def insertStock(ticker_symbol, current_value, todays_open)
    Thread.new {
      Stock.stock_cache[ticker_symbol.to_sym] = {
                                                  :current_value => current_value,
                                                  :todays_open => todays_open
                                                }
      puts "Updating cache with " + ticker_symbol
      sleep(60);
      Stock.stock_cache.delete(ticker_symbol.to_sym);
      puts "now reset"
    }
  end
