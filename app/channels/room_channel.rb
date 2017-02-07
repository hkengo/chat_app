class RoomChannel < ApplicationCable::Channel
  def subscribed
    stream_from @room_chennel if @room_chennel.present?
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(message)
    # TODO ユーザー認証
    room = Room.find(message['room_id'])
    set_room_channel(room)
    room.messages.create!(content: message['content'])
  end
  
  def set_room_channel(room)
    @room_chennel = "room_channel_#{room.id}"
  end
end
