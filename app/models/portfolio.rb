class Portfolio < ActiveRecord
  belongs_to :user
  has_many :stocks

end
