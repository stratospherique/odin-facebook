module ApplicationHelper
  def gravatar_for(user, size: 40)
    gravatar_id = Digest::MD5::hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}?s=#{size}"
  end

  def pending_friends
    @accept_friends = current_user.accept_friends.length
  end

  def get_notif
    current_user.notifications
  end

end
