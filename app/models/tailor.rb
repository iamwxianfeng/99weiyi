#encoding: utf-8

class Tailor < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :user
  has_many :tailor_areas
  has_many :bs_areas, :through => :tailor_areas,  :uniq => true
  has_many :tailor_comments
  has_many :reserves

  # validates :user_id, :uniqueness => { message: "裁缝已经存在" }

  attr_visible :id, :desc, :book_counts,  as: [:get,:list]
  attr_visible :desc, :scope, :work_time, :experience, :book_counts,  as: [:get]

  mount_uploader :desc_pic, ImageUploader

  def areas_str
    self.bs_areas.uniq.map(&:name).join(',')
  end

  def average_score
    @score ||= self.tailor_comments.average(:rating).to_i
  end

  def desc_pic_url version
    "https://" + [self.desc_pic.url,version].join("!")
  end

end
