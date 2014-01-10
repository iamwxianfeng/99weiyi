#encoding: utf-8

class V1::WeightsController < ApplicationController

  layout false

  def index
    weights = Weight.all
    lists = to_hashes(weights, :list)
    render json: lists
  end

end