#encoding: utf-8

class V1::UsersController < ApplicationController
  layout false

  before_filter :auth_required, except: [:signup, :signin, :oauth]

  def signup
     @user = login_user ||= User.new
     @user.email = params[:email]
     @user.password = params[:password]
     @user.password_confirmation = params[:password_confirmation]
     from_user = User.find_by_invite_code(params['invite_code'])
     @user.from_user_id = from_user.id if from_user
    if @user.save
      Resque.enqueue(UserMailer,@user.id,'activation')
      render json: { access_token: @user.access_token }
    else
      render status: 422, json: {message: @user.errors}
    end
  end

  def signin
    user = User.authenticate(params[:email], params[:password])
    if user
      render json: { access_token: user.access_token }
    else
      render status: 401, json: {message: '用户名或密码错误'}
    end
  end

  # def signout
  # end


  def oauth
    user = User.find_by_visitor_id(params[:uid]) || User.from_auth_hash(params)

    render json: { access_token: user.access_token }
  end

  def show
    user_h = login_user.to_hash(:get)
    user_h.merge!(avatar_url: login_user.avatar_url)
    user_h.merge!(login_user.body_hash)
    user_h.merge!(login_user.provider_hash)

    render json: user_h
  end

# 修改资料
  def patch
    login_user.update_attribute(:login, params[:login]) if params[:login].present?
    login_user.update_attribute(:province, params[:province]) if params[:province].present?
    login_user.update_attribute(:city,params[:city]) if params[:city].present?
    login_user.update_attribute(:gender,params[:gender]) if params[:gender].present?
    height_id = Height.find_by_value(params[:height].to_i).try(:id)
    weight_id = Weight.find_by_value(params[:weight].to_i).try(:id)
    login_user.update_attribute(:height_id, height_id) if height_id
    login_user.update_attribute(:weight_id, weight_id) if weight_id
    login_user.update_attribute(:style,params[:style]) if params[:style].present?

    user_h = login_user.to_hash(:get)
    user_h.merge!(avatar_url: login_user.avatar_url)
    user_h.merge!(login_user.body_hash)
    user_h.merge!(login_user.provider_hash)

    render json: user_h
  end

# 上传头像
  def avatar
    p "==params[:file]>>>>>>>>>== #{params[:file]}"
    file = params[:file]
    filename = Chima::Token.make_token
    file_name = params[:name].to_s
    extense_name = file_name.include?('.') ? file_name.split('.').last : "png"
    tempfile = Tempfile.new([filename,".#{extense_name}"])
    p "name: #{filename}, extense_name: #{extense_name}, tempfile: #{tempfile}"
    tempfile.write(params[:file])
    login_user.update_attribute(:avatar, tempfile)
    render json: { avatar_url: login_user.avatar_url }
  end

#预约列表
  def reserves
    reserves = Reserve.where(user_id: login_user.id)
    res = []
    reserves.each do |r|
     res << r.to_hash(:get).merge!({shop: r.shop.try(:name)})
    end
    render json: res
  end

#我的代金券
  def coupons
    coupons_arr = []
    total_count = login_user.find_coupon_total_count_by_sql.first.count || 0
    total_sum   = login_user.find_coupon_total_sum_by_sql.first.total || 0
    not_used_count = login_user.find_coupon_count_by_sql(UserCoupon::Status::NotUsed).first.count || 0
    not_used_sum = login_user.find_coupon_sum_by_sql(UserCoupon::Status::NotUsed).first.total || 0
    used_count = login_user.find_coupon_count_by_sql(UserCoupon::Status::Used).first.count || 0
    used_sum = login_user.find_coupon_sum_by_sql(UserCoupon::Status::Used).first.total || 0

    coupons_arr << { total: total_count, amount: total_sum }
    coupons_arr << { used: used_count, amount: used_sum }
    coupons_arr << { not_used: not_used_count, amount: not_used_sum }

    render json: coupons_arr
  end

#我的互动
# {
#   reserves: 3, //我的预约数
#   invite: 5, //我的邀请数
#   coupons: 5 //我的现金券张数
# }
  def interactions
    reserves_count = Reserve.where(user_id: login_user.id).count
    invite_count   =  login_user.invitations.count
    coupons_count  = login_user.user_coupons.count
    render json: { reserves: reserves_count, invite: invite_count, coupons: coupons_count }
  end

#我的邀请记录
  def invitations
    invitations_arr = []
    login_user.invitations.each do |ci|
      h = ci.to_hash(:get).merge!({invite_name: ci.value})
      invitations_arr << h
    end
    render json: invitations_arr
  end

end