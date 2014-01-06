# encoding:utf-8
class TypesController < ApplicationController
  before_filter :login_required

  def get_brands
    type = Type.find(params[:type_id])
    brands = type.brands
    items = brands.collect { |brand| brand.to_j }
    render :json => { retCode: 1, items: items  }
  end

end