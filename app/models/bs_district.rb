class BsDistrict < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :bs_city
  has_many :bs_areas

  attr_visible :id, :name, as: [:get,:list]
end
