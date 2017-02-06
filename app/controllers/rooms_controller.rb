class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    room = current_user.rooms.find(params[:id])
    @title = room.title
    @messages = room.messages.order("created_at ASC")
  end
end
