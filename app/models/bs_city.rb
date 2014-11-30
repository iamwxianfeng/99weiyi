class BsCity < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  has_many :bs_districts

  attr_visible :id, :name, as: [:get,:list]
end
