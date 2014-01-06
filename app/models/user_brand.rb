# encoding:utf-8
class UserBrand < AB
  belongs_to :user
  belongs_to :type
  belongs_to :brand
  belongs_to :model

  def human_feel
    Brand::FEEL.select { |ele| ele[:id] == feel_id }.first[:name]
  end

end