#encoding: utf-8

class V1::TailorsController < ApplicationController
  layout false

  # before_filter :auth_required

  def index
    tailor_areas = if params[:bs_district_id]
      TailorArea.where(bs_district_id: params[:bs_district_id])
    else
      bs_city_id = params[:bs_city_id] || 1
      TailorArea.where(bs_city_id: bs_city_id)
    end

    tailors = []
    tailor_areas.each do |a|
      tailor = a.tailor
      if tailor
        comments = []
        tailor.tailor_comments.first(3).each do |tc|
          comments << tc.to_hash(:get).merge!(commenter_name: tc.commenter_name)
        end
        user_h = { login: tailor.user.login, areas_str: tailor.areas_str, comments: comments }
        tailor = tailor.to_hash(:list).merge!(user_h)
        tailors << tailor
      end
    end

    render json: tailors
  end

  def show
    tailor = Tailor.find_by_id(params[:id])
    if tailor
      extend_h = { areas_str: tailor.areas_str, desc_pic: image_protocol(tailor.desc_pic_url), score: tailor.average_score }
      user = extend_h.merge!(tailor.user.to_hash(:tailor)).merge!(age: tailor.user.age)
      render json: tailor.to_hash(:get).merge!(extend_h)
    else
      render status:422, json: { message: "请求参数错误" }
    end

  end

end