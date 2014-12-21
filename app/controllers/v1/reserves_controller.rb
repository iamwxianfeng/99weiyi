#encoding: utf-8

class V1::ReservesController < ApplicationController
  layout false

  before_filter :auth_required

  def create
    height_id = Height.find_by_value(params[:height].to_i).try(:id) || 0
    weight_id = Weight.find_by_value(params[:weight].to_i).try(:id) || 0

    attr = {
      address: params[:address],
      name: params[:name],
      phone: params[:phone],
      service_time: params[:service_time],
      reserve_type: params[:reserve_type],
      height_id: height_id,
      weight_id: weight_id,
      tailor_id: params[:tailor_id],
      desc: params[:desc]
    }
    reserve = Reserve.new(attr)
    reserve.user_id = login_user.id
    reserve.save

    extend_h = {height: reserve.height.try(:value) || '', weight: reserve.weight.try(:value) || '' }
    render json: reserve.to_hash(:get).merge!(extend_h)
  end

  def show 
    reserve = Reserve.find_by_id(params[:id])
    if reserve
      extend_h = {height: reserve.height.try(:value) || '', weight: reserve.weight.try(:value) || '' }
      render json: reserve.to_hash(:get).merge!(extend_h)
    else
      render status: 422, json: { message: "预约信息信息不存在"}
    end
  end

end