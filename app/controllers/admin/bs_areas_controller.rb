# encoding:utf-8
class Admin::BsAreasController < ApplicationController
  layout 'admin'
  before_filter :logged_as_admin

  def create
    @bs_district = BsDistrict.find(params[:bs_district_id])
    @bs_area = @bs_district.bs_areas.create(params[:bs_area])
    redirect_to [:admin,@bs_district]
  end

   def edit
    @bs_district = BsDistrict.find(params[:bs_district_id])

    @bs_area = BsArea.find(params[:id])
  end

  def update
    @bs_district = BsDistrict.find(params[:bs_district_id])

    @bs_area = BsArea.find(params[:id])


    respond_to do |format|
      if @bs_area.update_attributes(params[:bs_area])
        format.html { redirect_to [:admin,@bs_district], notice: 'BsDistrict was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bs_area.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bs_district = BsDistrict.find(params[:bs_district_id])

    @bs_area = BsArea.find(params[:id])
    @bs_area.destroy

    respond_to do |format|
      format.html { redirect_to [:admin,@bs_district] }
      format.json { head :ok }
    end
  end

end