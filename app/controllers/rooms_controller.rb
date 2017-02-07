class RoomsController < ApplicationController
  before_action :authenticate_user!
  
  def show
    @room = current_user.rooms.find(params[:id])
  end
end
