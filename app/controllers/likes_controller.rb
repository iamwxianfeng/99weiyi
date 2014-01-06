#encoding:utf-8
class LikesController < ApplicationController
  before_filter :login_required

  def create
    attr = { user_id: current_user.id, user_brand_id: params[:user_brand_id] }
    like = Like.new attr
    if like.save
      render_json_ok
    else
      render_json_fail
    end
  end

end