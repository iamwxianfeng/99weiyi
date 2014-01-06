# encoding:utf-8
class UserBrandsController < ApplicationController
  before_filter :login_required

  def create
    user_brand = UserBrand.new(params[:user_brand])
    user_brand.save
    flash[:notice] = '保存成功'
    render "/home/brand_input"
  end

end