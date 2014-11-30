# encoding:utf-8
class Admin::BsAreasController < ApplicationController
  layout 'admin'
  before_filter :logged_as_admin

  def create
    @bs_district = BsDistrict.find(params[:bs_district_id])
    @bs_area = @bs_district.bs_areas.create(params[:bs_area])
    redirect_to [:admin,@bs_district]
  end

end