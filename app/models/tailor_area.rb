#encoding: utf-8

class TailorArea < ActiveRecord::Base

  belongs_to :tailor
  belongs_to :bs_area

  def self.condtion_sql hash
    conf = "WHERE bs_city_id = #{hash[:bs_city_id]} "
    if hash[:bs_district_id]
      conf << "AND bs_district_id = #{hash[:bs_district_id]} "
    end

    if hash[:bs_area_id]
      conf << "AND bs_area_id = #{hash[:bs_area_id]}"
    end
    "select * from tailor_areas #{conf}"
  end

end
