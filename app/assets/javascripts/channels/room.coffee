App.room = App.cable.subscriptions.create { channel: "RoomChannel", room_id: "" },
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel

  speak: (room_id, content) ->
    @perform 'speak', {room_id: room_id, content: content}

$(document).on 'click', '.js-submit-button', ->
  App.room.speak($('.js-room-id').val(), $('.js-content').val())