# encoding:utf-8
class Brand < ActiveRecord::Base
  has_many :types, :through => :type_brands
  has_many :type_brands
  has_many :models

  validates :name , :presence => { message: "不能为空" }

  # 1、穿着宽松，轻松舒适；2、刚好，不松不紧；3、有点收身，看上去精神；4、很紧身，非常合体。
  FEEL = [
    { id: 1, name: '穿着宽松，轻松舒适' },
    { id: 2, name: '刚好，不松不紧' },
    { id: 3, name: '有点收身，看上去精神' },
    { id: 4, name: '很紧身，非常合体' }
  ]

  def to_j
    { id: id, name: name }
  end

end
