#encoding: utf-8

class V1::MyController < ApplicationController
	layout false

  def forecast
	  password = "123456"
    email = "#{Chima::Token.make_token}@tmp_user.com"
    login = "临时用户#{User.last.id}"
    height_id = Height.find_by_value(params[:height].to_i) || 0
    weight_id = Weight.find_by_value(params[:weight].to_i) || 0
    attr = {email: email, login: login, password: password, password_confirmation: password,gender: params[:gender],height_id: height_id, weight_id: weight_id,style: params[:style]}
    user = User.new(attr)
    user.save(validate: false)
    get_forecast(user)
    if @forecast
	    user.forecast_id = @forecast.id
	    user.save(validate: false)
	    forecast_j = {chest: @forecast.chest, middle_chest: @forecast.middle_chest,shoulder: @forecast.shoulder,sleeve:  @forecast.sleeve, neck: @forecast.neck ,down_chest: @forecast.down_chest,ass: @forecast.ass, crosspiece: @forecast.crosspiece,foot: @forecast.foot }
	    forecast_j.merge!({access_token: user.access_token })
	    render json: forecast_j
	  else
	  	render status: 422, json: { message: "抱歉，您选择的身高和体重没有预估尺寸，您可以重新选择"}
    end
  end

  def actual_size
  	user = User.get_by_access_token(params[:access_token])
  	return render status: 401, json: { message: "授权过期，请登录"} if user.nil?
  	@actual_size = if user.actual_size
      user.actual_size
    else
    	actual_hash = {chest: params[:chest], middle_chest: params[:middle_chest],shoulder: params[:shoulder],sleeve: params[:sleeve],neck: params[:neck], arm: params[:arm], wrist: params[:wrist],ass: params[:ass],crosspiece: params[:crosspiece], down_chest: params[:down_chest]}
      ActualSize.new(actual_hash)
    end
    if @actual_size.new_record? && @actual_size.save or @actual_size.update_attributes(params[:actual_size])
      get_forecast(user)
      render status: 201, json: { message: "操作成功" }
    else
    	render status:422, json: { message: "操作失败，请重试"}
    end
  end

end