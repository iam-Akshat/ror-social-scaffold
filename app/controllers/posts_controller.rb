class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @post = Post.new
    timeline_posts
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save
      redirect_to posts_path, notice: 'Post was successfully created.'
    else
      timeline_posts
      render :index, alert: 'Post was not created.'
    end
  end

  private

  def timeline_posts
    @timeline_posts ||= current_user.friendships.where(status: 2).includes(:send_friend).map do |friendship|
      friendship.send_friend.posts.includes(:user).ordered_by_most_recent.all.take(5)
    end
    @timeline_posts.push(current_user.posts.includes(:user).ordered_by_most_recent.take(5))
    @timeline_posts = @timeline_posts.flatten
    @timeline_posts = @timeline_posts.sort { |p1, p2| p2.created_at <=> p1.created_at }
  end

  def post_params
    params.require(:post).permit(:content)
  end
end
