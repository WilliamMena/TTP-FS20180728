require 'pry'

class UsersController < ApplicationController

  before_action :validate_user

  def home
    @user = current_user
    @cash = ActionController::Base.helpers.number_to_currency(current_user.cash)
    render :home
  end
end
