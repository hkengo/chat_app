App.MakeRoomChannel = (room_id) ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: room_id },
    connected: ->
      # Called when the subscription is ready for use on the server
      console.log('connected')

    disconnected: ->
      # Called when the subscription has been terminated by the server
      console.log('disconnected')

    received: (data) ->
     # Called when there's incoming data on the websocket for this channel
      console.log('received')
      if data
        $('#messages').append(data['message'])

    speak: (user_id, content) ->
      console.log('speak')
      @perform 'speak', {user_id: user_id, content: content}

  $(document).on 'click', '.js-submit-button', ->
    App.room.speak($('.js-user-id').val(), $('.js-content').val())