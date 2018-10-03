require 'pry'

class UsersController < ApplicationController

  before_action :validate_user

  def home
    @user = current_user
    render :home
  end
end
