class HomeController < ApplicationController
  def index
    redirect_to "/users/#{current_user.id}/board" if current_user.present? 
  end


end
