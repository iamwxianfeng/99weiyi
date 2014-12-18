class TailorCommentImage < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :tailor_comment

  # mount_uploader :image, ImageUploader

  attr_visible :id, :image_id,  as: [:get,:list]

  def image_url
    file = DiskFile.find_by_id(image_id)
    file.nil? ? "" : file.file_url('460x350')
  end

end
