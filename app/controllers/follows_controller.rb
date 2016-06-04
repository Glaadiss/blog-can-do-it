class FollowsController < ApplicationController

  def index 
    @follows  = Follow.follows(current_user.id)
  end

  def new
    @follow = Follow.new
  end

  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy
    redirect_to :back
  end
  def create 
    @follow = Follow.new(follower_id: current_user.id, user_id: params[:follow][:user])
    if @follow.save
      redirect_to root_path
    else
      render 'new'
    end
  end
end
