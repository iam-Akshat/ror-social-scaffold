class Friendship < ApplicationRecord
    belongs_to :send_friend ,class_name: "User"
    belongs_to :recieved_friend ,class_name: "User"
end
