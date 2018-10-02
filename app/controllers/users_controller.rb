class UsersController < ApplicationController

  def home
    render html: '<div>Welcome Home</div>'.html_safe
  end
end
