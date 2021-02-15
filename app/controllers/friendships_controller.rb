class FriendshipsController < ApplicationController
  def create
    Friendship.send_friend_request(params['to_friend'].to_i, current_user.id)
    redirect_to user_path(User.find(params['to_friend'].to_i))
  end

  def update
    case params['commit']
    when 'Accept'
      Friendship.accept_friendship(request_params)
    when 'Reject'
      Friendship.reject_friendship(request_params)
    end
    redirect_to user_path(current_user)
  end

  def index; end

  private

  def request_params
    params.require('request').permit('send_friend_id', 'recieved_friend_id')
  end
end
