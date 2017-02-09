class FriendsController < ApplicationController
  before_action :set_user, only: [:follow, :unfollow, :block, :unblock]
  
  def index
    @group_rooms = current_user.rooms.groups
    @friend_users = current_user.following
  end
  
  def new
  end
  
  def search
    @user = User.find_by(email: params[:email])
    
    if @user
      flash.now[:notice] = "#{params[:email]}が見つかりました！"
    else
      flash.now[:alert] = "#{params[:email]}は見つかりません。"
    end
    
    render 'new'
  end
  
  def follow
    if current_user.following?(@user)
      flash.now[:alert] = "#{@user.name}はすでに友達になっています。"
      render 'new'
    elsif current_user.blocked?(@user)
      flash.now[:notice] = "#{@user.name}のブロックを解除しました。"
      redirect_to friends_url
    else
      current_user.follow(@user)
      flash.now[:notice] = "#{@user.name}を友達に追加しました。"
      redirect_to friends_url
    end
  end
  
  def unfollow
    current_user.unfollow(@user)
    
    redirect_to friends_url, alert: "#{@user.name}の友達を解除しました。"
  end
  
  def block
    current_user.block(@user)
    
    redirect_to friends_url, alert: "#{@user.name}をブロックしました。"
  end
  
  def unblock
    current_user.unblock(@user)
    
    redirect_to friends_url, alert: "#{@user.name}をブロックしました。"
  end
  
  private
  
  def set_user
    @user = User.find(params[:friend_id])
  end
end
