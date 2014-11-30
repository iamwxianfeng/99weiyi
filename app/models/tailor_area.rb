#encoding: utf-8

class TailorArea < ActiveRecord::Base

  belongs_to :tailor
  belongs_to :bs_area

end
