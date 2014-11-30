#encoding:utf-8
require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  include Weiyi::Mapper
  include Activerecord::Visible
  include Chima::Oauth

  attr_visible :id,:gender,:email, :style, :city, :invite_code, as: :get
  attr_visible :login, :avatar_url,:province, as:[:get,:tailor]

  set_table_name 'users'
  belongs_to :height
  belongs_to :weight
  has_one :actual_size
  has_one :tailor
  belongs_to :forecast_msize , :foreign_key => "forecast_id"
  belongs_to :forecast_wsize , :foreign_key => "forecast_id"
  has_one :disk_file, :as => :item

  has_many :user_brands
  has_many :likes
  has_many :watchers, :as => :watchable
  has_many :watchs, :class_name => "Watcher"
  has_many :questions
  has_many :answers
  has_many :reserves
  has_many :user_coupons
  has_many :invitations
  has_many :passports
  has_many :tailor_comments, foreign_key: 'commenter_id'

  mount_uploader :avatar, ImageUploader

  module Style
    LOOSE = 'loose' # 宽松
    NORMAL = 'normal' # 标准
    FIT = 'fit' # 合适
    TIGHT = 'tight' # 紧身
  end

  module Gender
    M = 0 # 男性
    W = 1 # 女性
  end

  module Role
    Temp = -1
    Normal = 0
    Measure = 1
    Admin = 2

  end

  # validates :login, :uniqueness => { message: "昵称已经存在" }
  # :length     => { :within => 1..40 }
  # :format     => { :with => Authentication.login_regex, :message => Authentication.bad_login_message }

  #  validates :name,  :format => { :with => Authentication.name_regex, :message => Authentication.bad_name_message },
  #    :length     => { :maximum => 100 },
  #    :allow_nil  => true

  # validates_inclusion_of :gender,:in => %w{ 0 1 }, :message => "性别不合法"

  validates :email, :presence   => { message: "email不能为空" },
    :uniqueness => { message: "email已经存在" },
    :format     => { :with => Authentication.email_regex, :message => Authentication.bad_email_message }
  # :length     => { :within => 6..100 }

 before_create :generate_access_token

  def self.authenticate(email, password)
    return nil if email.blank? || password.blank?
    #    u = find_in_state :first, :active, :conditions => {:login => login.downcase} # need to get the salt
    u = User.find_by_email(email)
    u && u.authenticated?(password) ? u : nil
  end

  def login=(value)
    write_attribute :login, (value ? value.downcase : nil)
  end

  def email=(value)
    write_attribute :email, (value ? value.downcase : nil)
  end

  def self.find_or_create(visitor)
    visitor_id = visitor[0].split('=')[1]
    visitor_nick = visitor[1].split('=')[1]
    user = find_by_visitor_id(visitor_id)
    if user.nil?
      user = User.new({ visitor_id: visitor_id,visitor_nick: visitor_nick })
      user.save
    end
    user
  end

  def self.get_by_access_token(access_token)
    User.find_by_access_token(access_token) #or raise MissingError.new :user
  end

  def self.from_auth_hash(hash)
    oauth_hash = Chima::Oauth.send("#{hash[:type]}_user_info".to_sym, hash)

    if oauth_hash.nil? || oauth_hash.empty?
      return nil
    else
      user = User.new(login: oauth_hash[:login], visitor_id: oauth_hash[:provider_uid])
      user.passports.new({
        provider_uid: oauth_hash[:provider_uid],
        provider_name: oauth_hash[:provider_name],
        avatar_url: oauth_hash[:avatar_url],
        nick_name: oauth_hash[:login],
        is_actived: true
      })
      user.save(validate: false)
      user
    end
  end

  # 胸腰差 = 胸围 - 中腰围
  def chest_middle_chest_diff
    chest = self.chest
    middle_chest = self.middle_chest
    diff = chest - middle_chest
    diff
  end

  # 胸围
  def chest
    actual_size = self.actual_size
    Rails.logger.debug "debug #{forecast_size}"
    actual_size.try(:chest) || forecast_size.try(:chest)
  end

  # 中腰围
  def middle_chest
    actual_size = self.actual_size
    actual_size.try(:middle_chest) || forecast_size.middle_chest
  end

  # 肩宽
  def shoulder
    actual_size = self.actual_size
    actual_size.try(:shoulder) || forecast_size.shoulder
  end

  # 袖长
  def sleeve
    actual_size = self.actual_size
    actual_size.try(:sleeve) || forecast_size.sleeve
  end

  # 腰围
  def down_chest
    actual_size = self.actual_size
    actual_size.try(:down_chest) || forecast_size.down_chest
  end

  # 臀围
  def ass
    actual_size = self.actual_size
    actual_size.try(:ass) || forecast_size.ass
  end

  # 横档
  def crosspiece
    actual_size = self.actual_size
    actual_size.try(:crosspiece) || forecast_size.crosspiece
  end

  # 裤长
  def foot
    actual_size = self.actual_size
    actual_size.try(:foot) || forecast_size.foot
  end

  # 领围
  def neck
    actual_size = self.actual_size
    actual_size.try(:neck) || forecast_size.neck
  end

  # 腕围
  def wrist
    actual_size = self.actual_size
    actual_size.try(:wrist) || 0
  end

  def forecast_size
    fs = if self.gender == 0
      self.forecast_msize
    else
      self.forecast_wsize
    end
    fs
  end

  def title
    self.login || self.name || self.email
  end

  def avatar_path
    DiskFile.where(:item_type=>"User",:item_id=>self.id).last.try(:path) || "/assets/avatar_common.png"
  end

  def tmp_user?
    (self.email || '').split(/@/)[1] == 'tmp_user.com'
  end

  def error
    self.errors.values.join("<br/>")
  end

  def fullname
    login || visitor_nick
  end

  def is_male?
    self.gender == Gender::M
  end

  def is_female?
    self.gender == Gender::W
  end

  def is_admin?
    self.role_id == Role::Admin
  end

  def is_messure?
    self.role_id >= Role::Measure # [admin,messure]
  end

  def age
    self.birthday.year == 1900 ? '' : Time.now.year - self.birthday.year
  end

  def find_coupon_total_count_by_sql
    sql = "select count(c.amount)  as count from coupons as c inner join user_coupons as uc on c.id = uc.`coupon_id` and uc.user_id=#{self.id};"
    self.class.find_by_sql(sql)
  end

  def find_coupon_count_by_sql status
    sql = "select count(c.amount)  as count from coupons as c inner join user_coupons as uc on c.id = uc.`coupon_id` and uc.status =#{status} and uc.user_id=#{self.id};"
    self.class.find_by_sql(sql)
  end

  def find_coupon_total_sum_by_sql
    sql = "select sum(c.amount)  as total from coupons as c inner join user_coupons as uc on c.id = uc.`coupon_id` and uc.user_id=#{self.id};"
    self.class.find_by_sql(sql)
  end

  def find_coupon_sum_by_sql status
    sql = "select sum(c.amount)  as total from coupons as c inner join user_coupons as uc on c.id = uc.`coupon_id` and uc.status =#{status} and uc.user_id=#{self.id};"
    self.class.find_by_sql(sql)
  end

  def human_gender
    self.gender == 0 ? '男' : '女'
  end

  def human_role
    r = case self.role_id
    when Role::Temp then '临时用户'
    when Role::Normal then '普通用户'
    when Role::Measure then '量体师'
    when Role::Admin  then '管理员'
    end
    r
  end

  def activate?
    self.email_verify == true
  end

  def activate!
    AB.transaction do
      self.email_verify = true
      self.activated_at = Time.now.utc
      self.activation_code = nil
      save(:validate => false)
      reward_invite
    end
  end

  def avatar_url
    upload_avatar = "https://" + [self.avatar.url,'a.120'].join("!")
    upload_avatar || self.avatar_src
  end

  def body_hash
    { height: self.height.try(:value) || '' , weight: self.weight.try(:value) || '' }
  end

  def provider_hash
    init_hash = {nick_name: '', avatar_url: '', is_actived: false }
    qq,weibo,weixin = init_hash, init_hash, init_hash

    self.passports.each do |p|
      if p.provider_name == "weibo"
        weibo = p.to_hash(:get)
      end

      if p.provider_name == "qq"
        qq = p.to_hash(:get)
      end

      if p.provider_name == "weixin"
        weixin = p.to_hash(:get)
      end
    end

    { qq: qq, weibo: weibo, weixin: weixin }

  end

  protected

  def generate_access_token
    self.access_token = self.class.make_token
    self.invite_code  = Chima::Token.random_code
    self.activation_code = self.class.make_token
  end

  def make_activation_code
    self.deleted_at = nil
    self.activation_code = self.class.make_token
  end

  # 给邀请者赠送优惠券
  def reward_invite
    invitor = User.find_by_id(self.from_user_id)
    if invitor
      coupon = Coupon.find_or_create_by_amount(30)
      UserCoupon.create({user_id: invitor.id, coupon_id: coupon.id})
    end
  end

end
