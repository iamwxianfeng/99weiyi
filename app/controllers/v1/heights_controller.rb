#encoding: utf-8

class V1::HeightsController < ApplicationController

  layout false

  def index
    heights = Height.all
    lists = to_hashes(heights, :list)
    render json: lists
  end

end