jQuery(document).on 'turbolinks:load', ->
  App.app = App.cable.subscriptions.create "AppChannel",
    connected: ->
      console.log('Connected to AppChannel')

    disconnected: ->
      console.log('Disconnected to AppChannel')

    received: (data) ->
      console.log('Received message: ' + data['message'])
      $('#online_users').html data['message']

    online: ->
      @perform 'online'
