class Stock < ApplicationRecord
  has_many :transactions
  has_many :users, through: :transactions
  has_many :portfolios, through: :users
end
