# encoding:utf-8
class Type < ActiveRecord::Base
  has_many :brands, :through => :type_brands
  has_many :type_brands
  validates :name, :presence => { message: '服装类型不能为空' }

  

end
