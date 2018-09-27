class User < ApplicationRecord
  validates :name, presence: true
  validates :email, uniqueness: true

  has_many :transactions
  has_many :stocks, through: :transactions

end
