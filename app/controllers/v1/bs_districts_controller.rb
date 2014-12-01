#encoding: utf-8

class V1::BsDistrictsController < ApplicationController
  layout false

  # before_filter :auth_required

  def index
    bs_city = BsCity.find(params[:bs_city_id])
    lists = []
    bs_city.bs_districts.each do |ds|
      areas = to_hashes(ds.bs_areas, :list)
      lists << ds.to_hash(:get).merge!({areas: areas})
    end
    render json: lists
  end

end