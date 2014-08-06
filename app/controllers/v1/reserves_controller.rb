#encoding: utf-8

class V1::ReservesController < ApplicationController
  layout false

  before_filter :auth_required

  def create
    attr = {address: params[:address], name: params[:name], phone: params[:phone], service_time: params[:service_time], shop_id: params[:shop_id], reserve_type: params[:reserve_type]}
    reserve = Reserve.new(attr)
    reserve.user_id = current_user.id
    reserve.save

    extend_h = {shop: reserve.shop.try(:name)}
    render json: reserve.to_hash(:get).merge!(extend_h)
  end

end