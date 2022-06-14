class AppChannel < ApplicationCable::Channel
  def subscribed
    stream_from "app_channel"
    current_user.increment!(:connection_counter)
    logger.info("#{current_user.inspect}")

    online if current_user.reload.connection_counter == 1
  end
  
  def unsubscribed
    current_user.decrement!(:connection_counter)
    logger.info("#{current_user.inspect}")

    online if current_user.reload.connection_counter == 0
  end
  
  def online
    logger.info "AppChannel online"

    OnlineService.new(user: current_user).perform
  end
end
