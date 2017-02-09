class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:edit, :update, :destroy, :show]
  before_action :set_friend_users, only: [:new, :edit]
  
  def new
    @room = Room.new
  end
  
  def create
    @room = current_user.rooms.create(room_params)
    add_users if params[:user_ids].present?
    
    if flash.now[:alert]
      render 'edit'
    else
      redirect_to room_url(@room), notice: flash.now[:notice]
    end
  end
  
  def edit
  end
  
  def update
    @room.update(room_params)
    add_users if params[:user_ids].present?
    
    if flash.now[:alert]
      render 'edit'
    else
      redirect_to root_url, notice: flash.now[:notice]
    end
  end
  
  def destroy
    @room.destroy
    
    redirect_to root_url, notice: flash.now[:notice]
  end
  
  def index
    @rooms = current_user.rooms
  end
  
  def show
  end
  
  private
  
  def room_params
    params.permit(
      :name,
      :is_group,
    )
  end
  
  def set_room
    @room = current_user.rooms.find(params[:id])
  end
  
  def set_friend_users
    @friend_users = current_user.following
  end
  
  def add_users
    # nil・空文字・重複を消す
    # user_emails = params[:user_emails].values.reject(&:blank?).uniq
    add_cuccess, add_fail = [], []
    return_users = []
    
    params[:user_ids].each do |user_id|
      user = User.find(user_id.to_i)
      if user && @room.can_add?(user)
        @room.add_user(user)
        return_users << user
        add_cuccess << user.name
      else
        add_fail << user.name
      end
    end
    
    flash.now[:notice] = "友達を追加しました。#{add_cuccess.join(' ')}" unless add_cuccess.empty?
    flash.now[:alert] = "友達を追加できませんでした。#{add_fail.join(' ')}" unless add_fail.empty?
    
    if add_fail.empty?
      return_users
    else
      nil
    end
  end
end
