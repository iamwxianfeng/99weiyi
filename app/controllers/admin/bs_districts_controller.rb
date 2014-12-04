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

  def edit
    @bs_district = BsDistrict.find(params[:id])
  end

  def update
    @bs_district = BsDistrict.find(params[:id])

    respond_to do |format|
      if @bs_district.update_attributes(params[:bs_district])
        format.html { redirect_to [:admin,@bs_district], notice: 'BsDistrict was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bs_district.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @bs_city = BsCity.find(params[:bs_city_id])
    # @bs_district = @bs_city.find(params[:id])
    @bs_district = BsDistrict.find(params[:id])
    @bs_district.destroy

    respond_to do |format|
      format.html { redirect_to [:admin,@bs_city] }
      format.json { head :ok }
    end
  end

end