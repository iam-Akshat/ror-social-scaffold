module FriendshipHelper
  def current_status(user)
    return nil if current_user == user

    friendship = Friendship.find_by(send_friend: current_user, recieved_friend: user)
    if friendship.nil?
      false
    else
      friendship.status
    end
  end

  def friend_or_not(user)
    case current_status(user)
    when 1
      'Request sent'
    when 2
      'Good Friends!'
    when 3
      'Request sent'
    when false
      false
    when nil
      ''
    end
  end
end
