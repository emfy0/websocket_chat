scrollMessagesDown = ->
  messages = $('#messages')

  scrollHeight = messages.prop("scrollHeight")

  currentUserId = $('.card-body').data('user-id')

  lastMessage = messages.children().last()
  if lastMessage.data('user-id') == currentUserId
    messages.scrollTop scrollHeight
    return

  lastElementHeight = lastMessage.outerHeight(true)
  if scrollHeight - Math.round(messages.scrollTop()) == lastElementHeight + messages.prop('clientHeight')
    messages.scrollTop scrollHeight

sendMessage = (event) ->
  message = event.target.value
  if message
    App.room.speak(message)
    event.target.value = ""

channel = undefined

jQuery(document).on 'turbolinks:load', ->
  messages = $('#messages')

  if !messages.length
    channel && channel.unsubscribe()
    return

  channel = createRoomChannel messages.data('room-id')
  messages.scrollTop(messages.prop("scrollHeight"))

  $(document).on 'keypress', '#message_body', (event) ->
    if event.keyCode is 13
      event.preventDefault()
      sendMessage event

createRoomChannel = (roomId) ->
  App.room = App.cable.subscriptions.create { channel: "RoomChannel", roomId: roomId },
    connected: ->

    disconnected: ->

    received: (data) ->
      $('#messages').append data['message']
      scrollMessagesDown()

    speak: (message) ->
      @perform 'speak', message: message
