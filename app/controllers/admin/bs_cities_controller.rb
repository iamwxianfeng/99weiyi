# encoding:utf-8
class Admin::BsCitiesController < ApplicationController
  layout 'admin'
  before_filter :logged_as_admin
  def index
    @bs_cities = BsCity.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @bs_cities }
    end
  end

  # GET /BsCitys/1
  # GET /BsCitys/1.json
  def show
    @bs_city = BsCity.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @bs_city }
    end
  end

  # GET /BsCitys/new
  # GET /BsCitys/new.json
  def new
    @bs_city = BsCity.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @bs_city }
    end
  end

  # GET /BsCitys/1/edit
  def edit
    @bs_city = BsCity.find(params[:id])
  end

  # POST /BsCitys
  # POST /BsCitys.json
  def create
    @bs_city = BsCity.new(params[:bs_city])

    respond_to do |format|
      if @bs_city.save
        format.html { redirect_to [:admin,@bs_city], notice: 'BsCity was successfully created.' }
        format.json { render json: @bs_city, status: :created, location: @bs_city }
      else
        format.html { render action: "new" }
        format.json { render json: @bs_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /BsCitys/1
  # PUT /BsCitys/1.json
  def update
    @bs_city = BsCity.find(params[:id])

    respond_to do |format|
      if @bs_city.update_attributes(params[:bs_city])
        format.html { redirect_to [:admin,@bs_city], notice: 'BsCity was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @bs_city.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /BsCitys/1
  # DELETE /BsCitys/1.json
  def destroy
    @bs_city = BsCity.find(params[:id])
    @bs_city.destroy

    respond_to do |format|
      format.html { redirect_to admin_bs_cities_url }
      format.json { head :ok }
    end
  end
end
