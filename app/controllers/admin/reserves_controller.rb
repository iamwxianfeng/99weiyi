# encoding:utf-8
class Admin::ReservesController < ApplicationController
  layout 'admin'
  before_filter :logged_as_messure
  # GET /reserves
  # GET /reserves.json
  def index
    @reserves = if current_user.is_admin?
      Reserve.all
    else
      Reserve.where(tailor_id: current_user.id)
    end
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @reserves }
    end
  end

  # GET /reserves/1
  # GET /reserves/1.json
  def show
    @reserve = Reserve.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @reserve }
    end
  end

  # GET /reserves/1/edit
  def edit
    @reserve = Reserve.find(params[:id])
  end

  # PUT /reserves/1
  # PUT /reserves/1.json
  def update
    @reserve = Reserve.find(params[:id])
    status = params[:reserve][:status].to_i
    if status != -1 && status < @reserve.status.to_i
      return redirect_to [:admin,@reserve], notice: 'opt error!!!'
    end

    respond_to do |format|
      if @reserve.update_attributes(params[:reserve])
        format.html { redirect_to [:admin,@reserve], notice: 'Reserve was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @reserve.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reserves/1
  # DELETE /reserves/1.json
  def destroy
    @reserve = Reserve.find(params[:id])
    @reserve.destroy

    respond_to do |format|
      format.html { redirect_to admin_reserves_url }
      format.json { head :ok }
    end
  end
end
