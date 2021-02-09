module FriendshipHelper
    def current_status
        return nil if current_user == @user 
        friendship = Friendship.find_by(send_friend: current_user,recieved_friend: @user)
        if friendship.nil?
            false
        else
            friendship.status
        end
    end
    def friend_or_not
        case self.current_status
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
