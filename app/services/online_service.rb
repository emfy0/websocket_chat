class OnlineService
  def initialize(user:)
    @user = user
  end

  def perform
    broadcast_message
  end

  private

  def broadcast_message
    ActionCable.server.broadcast "app_channel", message: render_user
  end

  def render_user
    ApplicationController.renderer.render json: user_json
  end

  private

  def user_json
    {
      nickname: @user.nickname,
      online: @user.connection_counter > 0 ? true : false,
      id: @user.id
    }
  end
end
