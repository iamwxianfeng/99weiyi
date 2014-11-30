# encoding:utf-8
class Admin::TailorAreasController < ApplicationController
  layout 'admin'
  before_filter :logged_as_admin

  def create
    bs_area = BsArea.find_by_id(params[:tailor_area][:bs_area_id])
    @tailor = Tailor.find_by_id(params[:tailor_area][:tailor_id])
    @tailor_area = TailorArea.new(params[:tailor_area])
    @tailor_area.bs_district_id = bs_area.bs_district_id
    @tailor_area.bs_city_id = bs_area.bs_district.bs_city_id
    respond_to do |format|
      if @tailor_area.save
        format.html { redirect_to [:admin,@tailor], notice: 'tailor_area was successfully created.' }
        format.json { render json: @tailor_area, status: :created, location: @tailor_area }
      else
        format.html { render action: "new" }
        format.json { render json: @tailor_area.errors, status: :unprocessable_entity }
      end
    end
  end
end