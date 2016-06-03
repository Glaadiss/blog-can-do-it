class FollowsController < ApplicationController

  def new
    @follow = Follow.new
  end
  def create 
    @follow=Follow.create(follower_id: params[:follow][:user_id], user_id: current_user.id)
    redirect_to root_path
  end
end
