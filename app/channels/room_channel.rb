class RoomChannel < ApplicationCable::Channel
  def subscribed
    @room_id = params[:room_id]
    stream_from Room.find(@room_id).channel
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def speak(message)
    # TODO ユーザー認証
    Room.find(@room_id)
        .messages
        .create!(content: message['content'])
  end
end
