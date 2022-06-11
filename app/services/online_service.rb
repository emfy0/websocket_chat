class OnlineService
  def initialize
    @users = User.online
  end

  def perform
    render_online_users
    broadcast_message
  end

  private

  def broadcast_message

    ActionCable.server.broadcast "app_channel",
      message: render_online_users

  end

  def render_online_users
    ApplicationController.renderer.render(partial: 'users/user', locals: {
      users: @users
    })
  end
end
