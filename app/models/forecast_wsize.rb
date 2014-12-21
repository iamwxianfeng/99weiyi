# encoding:utf-8
class ForecastWsize < ActiveRecord::Base

  include Weiyi::Mapper
  include Activerecord::Visible

  attr_visible :chest,:middle_chest,:shoulder, :sleeve, :neck, :down_chest, :ass, :crosspiece, :foot, as: :get

  belongs_to :height
  belongs_to :weight

  validates :height , :presence => { message: '不能为空' }
  validates :weight , :presence => { message: '不能为空' }

end
