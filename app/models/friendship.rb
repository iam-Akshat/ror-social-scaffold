class Friendship < ApplicationRecord
  belongs_to :send_friend, class_name: 'User'
  belongs_to :recieved_friend, class_name: 'User'

  scope :pending_requests, -> { where(status: 1) }
  scope :are_confirmed, -> { where(status: 2) }

  def accept_friendship
    update_attributes(status: 2)
    # creating 2nd record for easier querying
    Friendship.create!(
      send_friend_id: recieved_friend_id,
      recieved_friend_id: send_friend_id,
      status: 2
    )
  end

  def reject_friendship
    update_attributes(status: 3)
  end

  def self.send_friend_request(to_friend, from_friend)
    Friendship.create!(
      send_friend_id: from_friend,
      recieved_friend_id: to_friend,
      status: 1
    )
  end
end
