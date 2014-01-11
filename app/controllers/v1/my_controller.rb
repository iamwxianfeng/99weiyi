#encoding: utf-8

class V1::MyController < ApplicationController
	layout false

# render json: @weights
# render status: 410
  
  def forecast
	  password = "123456"
    email = "#{Chima::Token.make_token}@tmp_user.com"
    login = "临时用户#{User.last.id}"
    attr = {email: email, login: login, password: password, password_confirmation: password,gender: params[:gender],height_id: params[:height],weight_id: params[:weight_id],style: params[:style] }
    user = User.new(attr)
    user.save(:validate=>false)
    self.current_user = user
    get_forecast
    # Rails.logger.debug "debug #{@forecast.inspect}"
    @user.forecast_id = @forecast.id
    @user.save(:validate=>false)
    forecast_j = {chest: @forecast.chest, middle_chest: @forecast.middle_chest,shoulder: @forecast.shoulder,sleeve:  @forecast.sleeve, neck: @forecast.neck ,down_chest: @forecast.down_chest,ass: @forecast.ass, crosspiece: @forecast.crosspiece,foot: @forecast.foot }
    forecast_j.merge!({access_token: @user.access_token })
    render :json => forecast_j
  end

end