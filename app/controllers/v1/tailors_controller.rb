#encoding: utf-8

class V1::TailorsController < ApplicationController
  layout false

  def index
    tailor_areas =  unless params[:bs_city_id]
      TailorArea.where(bs_city_id: 1)
    else
      sql = TailorArea.condtion_sql(params)
      TailorArea.find_by_sql(sql)
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
      extend_h = { areas_str: tailor.areas_str, desc_pic_str: image_protocol(tailor.desc_pic.url), score: tailor.average_score }
      user_h = tailor.to_hash(:tailor).merge!(age: tailor.user.age,avatar_url: tailor.user.avatar_url)
      extend_h.merge!(user_h)
      render json: tailor.to_hash(:get).merge!(extend_h)
    else
      render status:422, json: { message: "请求参数错误" }
    end

  end

end