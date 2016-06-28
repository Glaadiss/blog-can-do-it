class FollowsController < ApplicationController

  def index 
    @follows  = Follow.follows(current_user.id)
  end


  def destroy
    @follow = Follow.find(params[:id])
    @follow.destroy
    redirect_to :back
  end
  def create 
    @follow = Follow.new(follower_id: current_user.id, user_id: params[:user_id])
    if @follow.save
      respond_to do |format| 
      format.js      
      end
    else
      render 'new'
    end
  end
end
