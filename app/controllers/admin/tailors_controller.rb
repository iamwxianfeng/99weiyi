# encoding:utf-8
class Admin::TailorsController < ApplicationController
  layout 'admin'
  before_filter :logged_as_admin
  def index
    @tailors = Tailor.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tailors }
    end
  end

  def new
    @tailor = Tailor.new
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @tailor }
    end
  end

  def create
    @tailor = Tailor.new(params[:tailor])

    respond_to do |format|
      if @tailor.save
        format.html { redirect_to [:admin,@tailor], notice: 'tailor was successfully created.' }
        format.json { render json: @tailor, status: :created, location: @tailor }
      else
        format.html { render action: "new" }
        format.json { render json: @tailor.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @tailor = Tailor.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @tailor }
    end
  end

  def edit
    @tailor = Tailor.find(params[:id])
  end

  def update
    @tailor = Tailor.find(params[:id])

    respond_to do |format|
      if @tailor.update_attributes(params[:tailor])
        format.html { redirect_to [:admin,@tailor], notice: 'tailor was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @tailor.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @tailor = Tailor.find(params[:id])
    @tailor.destroy

    respond_to do |format|
      format.html { redirect_to admin_tailors_url }
      format.json { head :ok }
    end
  end

end

