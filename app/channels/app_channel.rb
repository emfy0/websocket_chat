class AppChannel < ApplicationCable::Channel
  def subscribed
    stream_from "app_channel"
    current_user.online = true
    current_user.save

    online
  end
  
  def unsubscribed
    current_user.online = false
    current_user.save

    online
  end
  
  def online
    logger.info "AppChannel online"
    
    # ActionCable.server.broadcast "app_channel",
    # message: 'render_message'    
    OnlineService.new.perform
  end
end
