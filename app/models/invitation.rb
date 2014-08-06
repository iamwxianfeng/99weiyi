class Invitation < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :user

  attr_visible :id, :status, :created_at, as: [:get,:list]
end
