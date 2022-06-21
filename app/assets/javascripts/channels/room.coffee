scrollMessagesDown = ->
  messages = $('#messages')

  lastElementHeight = messages.children().last().outerHeight(true)
  scrollHeight = messages.prop("scrollHeight")

  if scrollHeight - messages.scrollTop() == lastElementHeight + messages.prop("clientHeight")
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
