#encoding: utf-8

class V1::BsCitiesController < ApplicationController
  layout false

  def index
    bs_cities = BsCity.all
    lists = to_hashes(bs_cities, :list)
    render json: lists
  end

end