class PostsController < ApplicationController
  skip_before_action :require_login

  def index
    @user = User.new
    @post = @user.posts.build(content: 'text', image: 'image')
  end
end
