class Friendship < ApplicationRecord
  belongs_to :send_friend, class_name: 'User'
  belongs_to :recieved_friend, class_name: 'User'

  scope :pending_requests, -> { where(status: 1) }
  scope :are_confirmed, -> { where(status: 2) }
end
