class Invitation < ApplicationRecord
  after_save do |invitation|
    
      notif = invitation.invited.notifications.build
      notif.message = "#{invitation.invitee.name} has sent you a friend request"
      notif.save
    
  end

      
  
  belongs_to :invitee, class_name: "User"
  belongs_to :invited, class_name: "User"
end
