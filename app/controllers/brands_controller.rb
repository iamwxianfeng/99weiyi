# encdoing:utf-8
class BrandsController < ApplicationController
  before_filter :login_required

  def get_models
    brand = Brand.find(params[:brand_id])
    models = brand.models
    items = models.collect { |model| model.to_j }
    render :json => { retCode: 1, items: items }
  end

end