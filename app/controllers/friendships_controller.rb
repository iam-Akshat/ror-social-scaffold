class FriendshipsController < ApplicationController
  def create
    friendship = Friendship.new
    friendship.send_friend_id = current_user.id
    friendship.recieved_friend_id = params['to_friend'].to_i
    friendship.status = 1
    friendship.save
    redirect_to user_path(params['to_friend'].to_i)
  end

  def update
    case params['commit']
    when 'Accept'
      friendship = Friendship.find_by(request_params)
      friendship.status = 2
      friendship.save
      # creating 2nd record for easier querying
      friendship2 = Friendship.new
      friendship2.send_friend_id = request_params['recieved_friend_id']
      friendship2.recieved_friend_id = request_params['send_friend_id']
      friendship2.status = 2
      friendship2.save
    when 'Reject'
      friendship = Friendship.find_by(request_params)
      friendship.status = 3
      friendship.save
    end
    redirect_to user_path(current_user)
  end

  def index; end

  private

  def request_params
    params.require('request').permit('send_friend_id', 'recieved_friend_id')
  end
end
