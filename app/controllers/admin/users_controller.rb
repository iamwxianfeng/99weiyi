# encoding:utf-8
class Admin::UsersController < ApplicationController
  layout 'admin'
  before_filter :logged_as_admin

  def index
    @users = if params[:role]
      User.where(role_id: params[:role].to_i)
    else
      User.all
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  def update_role
    user = User.find_by_id params[:id]
    if user && user.role_id != params[:role_id].to_i
      user.role_id = params[:role_id]
      user.save(validate: false)
      render_json_ok
    else
      render_json_fail
    end
  end

end