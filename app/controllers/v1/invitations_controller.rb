#encoding: utf-8

class V1::InvitationsController < ApplicationController

  layout false

  before_filter :auth_required

  def create
    invitation = Invitation.new(item_type: params[:type], value: params[:value], user_id: login_user.id)
    invitation.save
    render status: 200, json: { message: 'ok'}
  end

end