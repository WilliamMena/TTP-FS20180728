class User < ApplicationRecord
  has_many :transactions
  has_many :stocks, through: :transactions

  attr_accessor :name
  attr_accessor :email
  
  def initialize(name, email)
    @name = name
    @email = email
    @cash = 5000
  end
end
