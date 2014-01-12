#encoding:utf-8
class HomeController < ApplicationController
  before_filter :login_required, :except => [:step1,:step2]
  before_filter :find_user

  def index
  end

  def step1
    redirect_to "/home/my" and return if logged_in? and current_user.weight_id.present?
  end

  def step2
    gender = params[:gender]
    unless current_user
      email = "#{Chima::Token.make_token}@tmp_user.com"
      user = User.new({ email: email, login: "临时用户#{User.last.id}", password: '123456', password_confirmation: '123456' })
      user.save(:validate=>false)
      self.current_user = user
    end
    current_user.update_attribute :gender , gender
  end

  def step3
    current_user.update_attribute :height_id , params[:height]
    current_user.update_attribute :weight_id , params[:weight]
  end

  def mysize
    @user.update_attribute :style , params[:style]
    get_forecast
    Rails.logger.debug "debug #{@forecast.inspect}"
    return redirect_to '/home/step2', :flash => { :error => "抱歉，您选择的身高和体重没有预估尺寸，您可以重新选择" } if @forecast.nil?
    @user.forecast_id = @forecast.id
    @user.save(:validate=>false)
  end

  def how
    get_forecast
  end

  def measure
    get_forecast
    get_actual_size
  end

  def brand_input
  end

  def actual_size
    @actual_size = if current_user.actual_size
      current_user.actual_size
    else
      ActualSize.new(params[:actual_size])
    end
    if @actual_size.new_record? && @actual_size.save or @actual_size.update_attributes(params[:actual_size])
      get_forecast
      render :measure
    else
      redirect_to :back
    end
  end

  def recommended

  end

  def similar
    get_forecast
    @likes = current_user.likes
  end

  def mybrand
    @watch_users = current_user.watchs
    Rails.logger.debug "debug #{@watch_users.inspect}"
  end

  def my
    get_forecast
    @user_brands = current_user.user_brands
    @likes = current_user.likes
  end

  protected

  def find_user
    @user = current_user
  end

  def get_actual_size
    @actual_size = current_user.actual_size
  end

end