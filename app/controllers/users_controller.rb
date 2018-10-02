class UsersController < ApplicationController

  before_action :validate_user

  def home
    render :home
  end
end
