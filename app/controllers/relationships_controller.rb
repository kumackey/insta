class RelationshipsController < ApplicationController
  before_action :require_login, only: %i[create]

  def create
    @user = User.find(params[:followed_id])
    current_user.follow(@user)
  end
end
