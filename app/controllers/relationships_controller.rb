class RelationshipsController < ApplicationController
  def create
    followed_user = User.find(params[:user_id])
    follower = Relationship.new
    follower.follower_id = current_user.id
    follower.followed_id = followed_user.id
    follower.save
    redirect_back(fallback_location: root_path)
  end 
  
  def destroy
    followed_user = User.find(params[:user_id])
    follower = Relationship.find_by(follower_id: current_user.id, followed_id: followed_user.id)
    follower.destroy
    redirect_back(fallback_location: root_path)
  end 
  
  def followings
    user = User.find(params[:user_id])
    @followings = Relationship.where(follower_id: user.id)
    
  end
  
  def followers
    user = User.find(params[:user_id])
    @followers = Relationship.where(followed_id: user.id)
  end
end
