jQuery(document).on 'turbolinks:load', ->
  App.app = App.cable.subscriptions.create "AppChannel",
    connected: ->

    disconnected: ->

    received: (data) ->
      $('#online_users').html data['message']
