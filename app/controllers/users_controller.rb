#encoding:utf-8
class UsersController < ApplicationController
  before_filter :find_user, :only => [:destroy]

  def new
    if logged_in?
      if current_user.forecast_size
        redirect_to "/home/my" and return
      else
        redirect_to "/home/step1" and return
      end
    end
    @user = User.new
  end

  def create
    if current_user
      user = current_user
    end
    logout_keeping_session!
    @user = User.new(params[:user])
    #     @user.register! if @user && @user.valid?
    success = @user && @user.valid?
    if @user.save and success
      if request.xhr?
        session[:user_id] = user.id
        @user.gender = user.gender
        @user.height_id = user.height_id
        @user.weight_id = user.weight_id
        @user.style = user.style
        @user.forecast_id = user.forecast_id
        @user.save(:validate=>false)
        self.current_user = @user
        render_json_ok
      else
        redirect_back_or_default('/', :notice => "Thanks for signing up!  We're sending you an email with your activation code.")
      end
    else
      if request.xhr?
        render :json => { retCode: 0, errors: @user.error }
      else
        render :action => 'new'
      end
    end
  end

  def activate
    logout_keeping_session!
    user = User.find_by_activation_code(params[:activation_code]) unless params[:activation_code].blank?
    case
    when (!params[:activation_code].blank?) && user && !user.active?
      user.activate!
      redirect_to '/login', :notice => "Signup complete! Please sign in to continue."
    when params[:activation_code].blank?
      redirect_back_or_default('/', :flash => { :error => "The activation code was missing.  Please follow the URL from your email." })
    else
      redirect_back_or_default('/', :flash => { :error  => "We couldn't find a user with that activation code -- check your email? Or maybe you've already activated -- try signing in." })
    end
  end

  def edit

  end

  def update
    user = current_user
    if user.update_attributes params[:user]
      Rails.logger.debug "debug ok #{user.errors.inspect}"
      render :edit
    else
      Rails.logger.debug "debug #{user.errors.inspect}"
      render :edit
    end
  end

  def show
    get_forecast
    @user_brands = current_user.user_brands
    @likes = current_user.likes
  end

  def avatar
  end

  def upload_avatar
    @disk_file = DiskFile.new
    file = params[:file]
    @disk_file.digest = Chima::File.digest(file)
    @disk_file.item_type = 'User'
    @disk_file.item_id = current_user.id
    @disk_file.user_id = current_user.id
    tmp_location = file.tempfile
    FileUtils.mv(tmp_location,@disk_file.location)
    if @disk_file.save
      FileUtils.chmod 0755, @disk_file.location, :verbose => true
      render :avatar
    else
      render :avatar
    end
  end

  def update_avatar
    user = current_user
    disk_files = DiskFile.where(:item_type=>"User",:item_id=>user.id)
    disk_files[0..-2].each do|disk_file|
      disk_file.destroy
    end
    render_json_ok
  end

  def cancel_avatar
    user = current_user
    disk_files = DiskFile.where(:item_type=>"User",:item_id=>user.id)
    disk_files[1..-1].each do|disk_file|
      disk_file.destroy
    end
    render_json_ok
  end

  def destroy
    @user.delete!
    redirect_to users_path
  end

  protected

  def find_user
    @user = User.find(params[:id])
  end

end
