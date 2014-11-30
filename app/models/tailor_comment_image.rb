class TailorCommentImage < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :tailor_comment

  mount_uploader :image, ImageUploader

  attr_visible :id, :image,  as: [:get,:list]
end
