class UsersController < ApplicationController

  before_action :validate_user

  def home
    render html: '<div>Welcome Home</div>'.html_safe
  end
end
