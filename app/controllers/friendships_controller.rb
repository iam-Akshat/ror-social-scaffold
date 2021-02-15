class FriendshipsController < ApplicationController
  def create
    Friendship.send_friend_request(params['to_friend'].to_i, current_user.id)
    redirect_to user_path(User.find(params['to_friend'].to_i))
  end

  def update
    friendship = Friendship.find_by(request_params)
    case params['commit']
    when 'Accept'
      friendship.accept_friendship
    when 'Reject'
      friendship.reject_friendship
    end
    redirect_to user_path(current_user)
  end

  def index; end

  private

  def request_params
    params.require('request').permit('send_friend_id', 'recieved_friend_id')
  end
end
