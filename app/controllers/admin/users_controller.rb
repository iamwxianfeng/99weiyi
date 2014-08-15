# encoding:utf-8
class Admin::UsersController < ApplicationController
  layout 'admin'
  # before_filter :logged_as_manager

  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end
end