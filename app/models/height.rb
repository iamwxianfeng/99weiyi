# encoding:utf-8
class Height < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  attr_visible :id,:value, as: [:get,:list]

  validates :value , :presence => { message: '不能为空' }

  default_scope :order=>"value ASC"
end
