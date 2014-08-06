# encoding:utf-8

class Reserve < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  set_table_name :reserves

  belongs_to :user
  belongs_to :shop

  attr_visible :id,:address,:name,:phone, :service_time, :reserve_type, :created_at, as: [:get,:list]

  module Type
    SMLT = 1 #上门量体
    SMDZ = 2 #上门定制
    TYD  = 3 #体验店预约
  end

  def human_type
    s = case self.reserve_type
        when Type::SMLT then '上门量体'
        when Type::SMDZ then '上门定制'
        when Type::TYD then '体验店预约'
        end
    s
  end

end
