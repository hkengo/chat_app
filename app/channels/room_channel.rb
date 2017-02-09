class RoomChannel < ApplicationCable::Channel
  def subscribed
    set_room
    stream_from @room.channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(message)
    @room.messages.create!(user_id: message['user_id'], content: message['content'])
  end
  
  private
  
  def set_room
    @room = current_user.rooms.find(params[:room_id])
  end
end
