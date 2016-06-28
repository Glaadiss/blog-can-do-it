class UsersController < ApplicationController
  def index
    par = params[:name] 
    @users =  User.no_followed(current_user, par)
  end


end
