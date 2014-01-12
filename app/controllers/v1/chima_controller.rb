 #encoding: utf-8

class V1::ChimaController < ApplicationController

  layout false
  
  include ApplicationHelper
  include SuitHelper

  before_filter :request_user

# 西服
  def xifu
    h = {}
    h[:chest] = show_suit_chest(@user)
    h[:middle_chest] = show_suit_middle_chest(@user)
    h[:xiabai] = show_suit_xiabai(@user)
    h[:front_length] = show_suit_front_length(@user)
    h[:back_length] = show_suit_back_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve
  	render json: h
  end

# 西裤
  def xiku
    h = {}
    h[:down_chest] = show_xiku_down_chest(@user)
    h[:ass] = show_xiku_ass(@user)
    h[:zongdang] = show_xiku_zongdang(@user)
    h[:crosspiece] = show_xiku_crosspiece(@user)
    h[:foot] = show_xiku_foot(@user)
    h[:kukou] = show_xiku_kukou(@user)
    render json: h
  end

# 正装衬衫
  def dressshirt
    h = {}
    h[:chest] = show_real_dressshirt_chest(@user)
    h[:middle_chest] = show_dressshirt_middle_chest(@user)
    h[:xiabai] = show_dressshirt_xiabai(@user)
    h[:length] = show_dressshirt_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve
    h[:neck] = @user.neck
    h[:wrist] = @user.wrist + 7
    h[:short_length] = show_dressshirt_short_length(@user)
    render json: h
  end

# 休闲衬衫
  def casualshirt
    h = {}
    h[:chest] = show_casualshirt_chest(@user)
    h[:middle_chest] = show_casualshirt_middle_chest(@user)
    h[:xiabai] = show_dressshirt_xiabai(@user)
    h[:length] = show_dressshirt_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve
    h[:neck] = @user.neck
    h[:wrist] = @user.wrist + 7
    h[:short_length] = show_dressshirt_short_length(@user)
    render json: h
  end

# T恤
  def tshirt
    h = {}
    h[:chest] = show_tshirt_chest(@user)
    h[:middle_chest] = show_tshirt_middle_chest(@user)
    h[:length] = show_tshirt_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve + 1
    render json: h
  end

# POLO衫
  def polo
    h = {}
    h[:chest] = show_polo_chest(@user)
    h[:length] = show_polo_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve + 1
    render json: h
  end

# 羽绒服
  def downcote
    h = {}
    h[:chest] = show_coat_chest(@user)
    h[:middle_chest] = show_coat_middle_chest(@user)
    h[:xiabai] = show_coat_chest(@user) - 2
    h[:length] = show_coat_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve + 1
    render json: h
  end

# 夹克
  def jack
    h = {}
    h[:chest] = show_jack_chest(@user)
    h[:length] = show_coat_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve
    render json: h
  end

# 外套
  def cote
    h = {}
    h[:chest] = show_jack_chest(@user)
    h[:length] = show_coat_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve
    render json: h
  end

# 大衣
  def overcote
    h = {}
    h[:chest] = show_coat_chest(@user) + 2
    h[:middle_chest] = show_coat_middle_chest(@user) + 2
    h[:xiabai] = show_coat_chest(@user) + 2
    h[:length] = show_overcoat_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve
    render json: h
  end

# 毛衣、针织衫、卫衣
  def sweater
    h = {}
    h[:chest] = show_sweater_chest(@user)
    h[:xiabai] = show_sweater_chest(@user) - 4
    h[:length] = show_sweater_length(@user)
    h[:shoulder] = @user.shoulder - 3
    h[:sleeve] = @user.sleeve + 3
    render json: h
  end

# 风衣
  def dustcote
    h = {}
    h[:chest] = show_coat_chest(@user)
    h[:middle_chest] = show_coat_middle_chest(@user)
    h[:xiabai] = show_coat_chest(@user) - 2
    h[:length] = show_coat_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve + 1
    render json: h
  end

# 中山装
  def suncote
    h = {}
    h[:chest] = show_coat_chest(@user)
    h[:middle_chest] = show_coat_middle_chest(@user)
    h[:xiabai] = show_coat_chest(@user) - 2
    h[:front_length] = show_coat_length(@user)
    h[:back_length] = show_coat_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve + 1
    render json: h
  end

# 立领
  def standcote
    h = {}
    h[:chest] = show_suit_chest(@user)
    h[:middle_chest] = show_suit_middle_chest(@user)
    h[:xiabai] = show_suit_xiabai(@user) - 2
    h[:front_length] = show_suit_front_length(@user)
    h[:back_length] = show_suit_back_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve
    render json: h
  end


# 唐装
  def tangcote
    h = {}
    h[:chest] = show_suit_chest(@user)
    h[:middle_chest] = show_suit_middle_chest(@user)
    h[:xiabai] = show_suit_xiabai(@user)
    h[:front_length] = show_suit_front_length(@user)
    h[:back_length] = show_suit_back_length(@user)
    h[:shoulder] = @user.shoulder
    h[:sleeve] = @user.sleeve
    render json: h
  end

  private 

    def request_user
    	@user = User.find_by_access_token(params[:access_token])
      if  params[:access_token].nil? || @user.nil?
        return render status: 410, json: {message: "qing deng lu "}
      end

    	# if @user.nil?
    	# 	return render status: 410, json: {message: "qing deng lu "}
    	# end

      if params[:style]
        @user.style = params[:style]
        @user.save
      end

    end

end