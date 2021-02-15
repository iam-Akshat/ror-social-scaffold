class Friendship < ApplicationRecord
  belongs_to :send_friend, class_name: 'User'
  belongs_to :recieved_friend, class_name: 'User'

  scope :pending_requests, -> { where(status: 1) }
  scope :are_confirmed, -> { where(status: 2) }

  def self.accept_friendship(request_params)
    friendship = Friendship.find_by(request_params)
    friendship.status = 2
    friendship.save
    # creating 2nd record for easier querying
    friendship2 = Friendship.new
    friendship2.send_friend_id = request_params['recieved_friend_id']
    friendship2.recieved_friend_id = request_params['send_friend_id']
    friendship2.status = 2
    friendship2.save
  end

  def self.reject_friendship(request_params)
    friendship = Friendship.find_by(request_params)
    friendship.status = 3
    friendship.save
  end

  def self.send_friend_request(to_friend, from_friend)
    friendship = Friendship.new
    friendship.send_friend_id = from_friend
    friendship.recieved_friend_id = to_friend
    friendship.status = 1
    friendship.save
  end
end
