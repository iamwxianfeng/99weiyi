# encoding:utf-8
class WatchersController < ApplicationController
  before_filter :login_required

  def create
    attr = { user_id: current_user.id, watchable_type: 'User', watchable_id: params[:user_id] }
    watcher = Watcher.new attr
    if watcher.save
      render_json_ok
    else
      render_json_fail
    end
  end

end