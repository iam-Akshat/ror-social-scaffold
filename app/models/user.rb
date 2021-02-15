class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :friendships, foreign_key: 'send_friend_id'
  # has_many :send_friends, through: :friendships

  has_many :friendships, foreign_key: 'recieved_friend_id'
  has_many :recieved_friends, through: :friendships

  has_many :pending_friendships, -> { where status: 1 }, class_name: 'Friendship', foreign_key: 'recieved_friend_id'
  has_many :pending_friends, through: :pending_friendships, source: :send_friend

  has_many :confirmed_friendships, -> { where status: 2 }, class_name: 'Friendship', foreign_key: 'send_friend_id'
  has_many :recieved_friends, through: :confirmed_friendships

  def user_and_friends_posts
    Post.where(user: recieved_friends.to_a << self).ordered_by_most_recent.take(10)
  end
end
