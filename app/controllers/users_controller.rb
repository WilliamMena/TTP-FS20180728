require 'pry'

class UsersController < ApplicationController

  before_action :validate_user

  def home
    @user = current_user
    @cash = ActionController::Base.helpers.number_to_currency(current_user.cash)
    @value = current_user.portfolio_value
    @transaction = current_user.transactions.new
    render :home
  end

  def transactions
    @transactions = current_user.transactions.reverse
    render :transactions
  end
end
