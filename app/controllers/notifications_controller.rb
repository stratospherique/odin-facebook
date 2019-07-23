class NotificationsController < ApplicationController
  def index
    if current_user
    @notifications = current_user.notifications
    end
  end
end
