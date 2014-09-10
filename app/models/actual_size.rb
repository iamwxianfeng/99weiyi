# encoding:utf-8
class ActualSize < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :user

  attr_visible :chest, :middle_chest, :shoulder, :sleeve, :neck, :arm, :wrist, as: [:get,:list]
  attr_visible :down_chest, :ass, :crosspiece, :foot, :knee, :zongdang, as: [:get,:list]
end