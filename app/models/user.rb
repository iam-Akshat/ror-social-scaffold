class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships,foreign_key: 'send_friend_id'
  has_many :send_friends,through: :friendships

  has_many :friendships,foreign_key: 'recieved_friend_id'
  has_many :recieved_friends,through: :friendships


end
