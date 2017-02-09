class RoomsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_room, only: [:edit, :update, :destroy, :show]
  
  def new
    @room = Room.new
  end
  
  def create
    @room = current_user.rooms.create(room_params)
    add_users if params[:user_emails].present?
    
    if flash[:alert]
      render 'edit'
    else
      redirect_to root_url, notice: flash[:notice]
    end
  end
  
  def edit
  end
  
  def update
    @room.update(room_params)
    add_users if params[:user_emails].present?
    
    if flash[:alert]
      render 'edit'
    else
      redirect_to root_url, notice: flash[:notice]
    end
  end
  
  def destroy
    @room.destroy
    
    redirect_to root_url, notice: flash[:notice]
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
    )
  end
  
  def set_room
    @room = current_user.rooms.find(params[:id])
  end
  
  def add_users
    # nil・空文字・重複を消す
    user_emails = params[:user_emails].values.reject(&:blank?).uniq
    add_cuccess, add_fail = [], []
    return_users = []
    
    user_emails.each do |email|
      user = User.find_by(email: email)
      if user && @room.can_add?(user)
        @room.add_user(user)
        return_users << user
        add_cuccess << email
      else
        add_fail << email
      end
    end
    
    flash[:notice] = "友達を追加しました。#{add_cuccess.join(' ')}" unless add_cuccess.empty?
    flash[:alert] = "友達を追加できませんでした。#{add_fail.join(' ')}" unless add_fail.empty?
    
    if add_fail.empty?
      return_users
    else
      nil
    end
  end
end
