#encoding: utf-8

class BsArea < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :bs_district
  has_many :tailor_areas #, :dependent => :destory
  has_many :tailors, :through => :tailor_areas,  :uniq=>true

  attr_visible :id, :name, as: [:get,:list]
end
