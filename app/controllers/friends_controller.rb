class FriendsController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow]
  
  def index
    @group_rooms = current_user.rooms.groups
    @friend_users = current_user.following
  end
  
  def new
  end
  
  def search
    @user = User.find_by(email: params[:email])
    
    if @user
      flash[:notice] = "#{params[:email]}が見つかりました！"
    else
      flash[:alert] = "#{params[:email]}は見つかりません。"
    end
    
    render 'new'
  end
  
  def follow
    if current_user.following?(@user)
      flash[:alert] = "#{@user.email}はすでに友達になっています。"
      render 'new'
    else
      current_user.follow(@user)
      flash[:notice] = "#{@user.email}を友達に追加しました。"
      redirect_to users_url(@user)
    end
  end
  
  def unfollow
    current_user.unfollow(@user)
    
    redirect_to 'index', alert: "#{@user.email}をブロックしました。"
  end
  
  private
  
  def set_user
    @user = User.find(params[:friend_id])
  end
end
