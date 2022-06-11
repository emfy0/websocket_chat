App.app = App.cable.subscriptions.create "AppChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    $('#online_users').html data['message']

  online: ->
    @perform 'online'

jQuery(document).on 'turbolinks:load', ->
  if $('#online_users').length > 0
    App.app.online()
