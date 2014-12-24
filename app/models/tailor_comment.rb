class TailorComment < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :tailor
  belongs_to :user
  has_many :tailor_comment_images

  attr_visible :id, :rating, :content,  as: [:get,:list]

  validates :rating, inclusion: { in: [1,2,3,4,5],
    message: "%{value} is not a valid size" }

  default_scope :order => "created_at desc"


  self.per_page = 10

  def commenter
    User.find_by_id(self.commenter_id)
  end

  def commenter_name
    commenter.try(:login) || commenter.try(:email)
  end

  def comment_images
    self.tailor_comment_images.collect{ |c| c.image_url}
  end


end
