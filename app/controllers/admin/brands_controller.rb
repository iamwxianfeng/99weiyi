class Admin::BrandsController < ApplicationController
  layout 'admin'
  # GET /brands
  # GET /brands.json
  def index
    @brands = Brand.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @brands }
    end
  end

  # GET /brands/1
  # GET /brands/1.json
  def show
    @brand = Brand.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @brand }
    end
  end

  # GET /brands/new
  # GET /brands/new.json
  def new
    @brand = Brand.new
    @type_ids = []

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @brand }
    end
  end

  # GET /brands/1/edit
  def edit
    @brand = Brand.find(params[:id])
    @type_ids = @brand.types.map(&:id)
  end

  # POST /brands
  # POST /brands.json
  def create
    @brand = Brand.new(params[:brand])
    params[:types].each do |type|
      @brand.types << Type.find(type)
    end

    respond_to do |format|
      if @brand.save
        format.html { redirect_to [:admin,@brand], notice: 'Brand was successfully created.' }
        format.json { render json: @brand, status: :created, location: @brand }
      else
        format.html { render action: "new" }
        format.json { render json: @brand.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /brands/1
  # PUT /brands/1.json
  def update
    @brand = Brand.find(params[:id])
    types = Type.where(:id=>params[:types])
    @brand.types = types

    if @brand.update_attributes(params[:brand])
      redirect_to [:admin,@brand], notice: 'Brand was successfully updated.'
    else
      render action: "edit"
    end
  end

  # DELETE /brands/1
  # DELETE /brands/1.json
  def destroy
    @brand = Brand.find(params[:id])
    @brand.destroy

    respond_to do |format|
      format.html { redirect_to admin_brands_url }
      format.json { head :ok }
    end
  end
end
