# encoding:utf-8

class Passport < ActiveRecord::Base

  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :user

  attr_visible :avatar_url,:nick_name, :is_actived, as: :get
end
