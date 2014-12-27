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
          comments << tc.to_hash(:get).merge!(commenter_name: tc.commenter_name, created_at: string_time(tc.created_at))
        end
        extend_h = { login: tailor.user.human_login, avatar_url: tailor.user.avatar_url('a.90'), desc_pic: tailor.desc_pic_url('460x350'), areas_str: tailor.areas_str,score: tailor.average_score,  comments: comments }
        tailor = tailor.to_hash(:list).merge!(extend_h)
        tailors << tailor
      end
    end

    render json: tailors
  end

  def show
    tailor = Tailor.find_by_id(params[:id])
    if tailor
      extend_h = { areas_str: tailor.areas_str, desc_pic: tailor.desc_pic_url('460x350'), score: tailor.average_score }
      user_h = tailor.user.to_hash(:tailor).merge!(age: tailor.user.age,avatar_url: tailor.user.avatar_url('a.60'))
      extend_h.merge!(user_h)
      render json: tailor.to_hash(:get).merge!(extend_h)
    else
      render status:422, json: { message: "请求参数错误" }
    end

  end

end
