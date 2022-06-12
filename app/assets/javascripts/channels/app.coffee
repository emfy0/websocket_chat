App.app = App.cable.subscriptions.create "AppChannel",
  connected: ->

  disconnected: ->

  received: (data) ->
    updatePage data['message']

updatePage = (json) ->
  if $('#online_users').length == 0
    return

  data = JSON.parse json

  user_id = data['id']
  user_page = $('#online_users').find("[data-user-id=#{user_id}]")

  if user_page.length > 0 && data['online'] == false
    user_page.remove()
  else if user_page.length == 0 && data['online'] == true
    $('#online_users').append("<p data-user-id=#{user_id}> #{data['nickname']}</p>")
