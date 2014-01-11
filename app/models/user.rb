#encoding:utf-8
require 'digest/sha1'

class User < ActiveRecord::Base
  include Authentication
  include Authentication::ByPassword
  include Authentication::ByCookieToken
  set_table_name 'users'
  belongs_to :height
  belongs_to :weight
  has_one :actual_size
  belongs_to :forecast_msize , :foreign_key => "forecast_id"
  belongs_to :forecast_wsize , :foreign_key => "forecast_id"
  has_one :disk_file, :as => :item

  has_many :user_brands
  has_many :likes
  has_many :watchers, :as => :watchable
  has_many :watchs, :class_name => "Watcher"

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

  validates :login, :presence => { message: '昵称不能为空' },
    :uniqueness => { message: "昵称已经存在" }
  # :length     => { :within => 1..40 }
  # :format     => { :with => Authentication.login_regex, :message => Authentication.bad_login_message }

  #  validates :name,  :format => { :with => Authentication.name_regex, :message => Authentication.bad_name_message },
  #    :length     => { :maximum => 100 },
  #    :allow_nil  => true

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

  def avatar_path
    DiskFile.where(:item_type=>"User",:item_id=>self.id).last.try(:path) || avatar_src
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

  protected
  
  def generate_access_token
    self.access_token = self.class.make_token
  end

  def make_activation_code
    self.deleted_at = nil
    self.activation_code = self.class.make_token
  end

end
