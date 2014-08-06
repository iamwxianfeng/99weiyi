# encoding:utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  include AuthenticatedSystem
  include ApplicationHelper
  #  helper_method :current_user

  def render_json_ok
    render :json => { retCode: 1 }
  end

  def render_json_fail
    render :json => { retCode: 0 }
  end

  def render_json_oauth_error
    render :json => { error: '用户名或密码错误'}
  end

  def get_forecast(user = nil)
    @user ||=  user || current_user
    if @user.gender == User::Gender::M
      height_forecasts = ForecastMsize.where(:height_id=>@user.height_id)
      weight_forecasts = ForecastMsize.where(:weight_id=>@user.weight_id)
    else
      height_forecasts = ForecastWsize.where(:height_id=>@user.height_id)
      weight_forecasts = ForecastWsize.where(:weight_id=>@user.weight_id)
    end
    forecasts = (height_forecasts + weight_forecasts ).uniq
    arr = []
    ##
    # 预估尺寸算法
    # 身高差值 + 体重差值 最小的
    forecasts.each_with_index do |forecast,index|
      unless @user.height.nil? || @user.weight.nil?
        arr << (forecast.height.value - @user.height.value).abs + (forecast.weight.value - @user.weight.value).abs
      end
    end
    min = arr.min
    index = arr.find_index(min)
    @forecast = forecasts[index.to_i]
  end


  def to_hashes arr, role
    arr.map { |doc| doc.to_hash role }
  end

  def logged_as_manager
    # unless current_user && current_user.is_manager?
    #   redirect_back_or_default('/', :notice => "您无权访问.")
    # end
  end

  # def auth_required
  #   unless signed_in?
  #     return render :json => { error: '用户名或密码错误'}
  #   end
  # end

end
