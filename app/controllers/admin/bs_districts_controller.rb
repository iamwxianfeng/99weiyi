# encoding:utf-8
class Admin::BsDistrictsController < ApplicationController
  layout 'admin'
  before_filter :logged_as_admin

  def create
    @bs_city = BsCity.find(params[:bs_city_id])
    @bs_district = @bs_city.bs_districts.create(params[:bs_district])
    redirect_to [:admin,@bs_city]
  end

  def show

    @bs_district = BsDistrict.find(params[:id])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bs_district }
    end

  end

end