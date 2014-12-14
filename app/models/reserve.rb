# encoding:utf-8

class Reserve < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  set_table_name :reserves

  belongs_to :user
  belongs_to :height
  belongs_to :weight
  belongs_to :tailor

  # validates :status, inclusion: { in: %w{waiting confirmed measured producing succeeded failed},
  #   message: "%{value} is not a valid size" }
 #   0： 待确认 ，1： 已确认，2： 已完成量体，3： 生产中 ，4： 成功
 # ，－1： 失败

  attr_visible :id,:address,:name,:phone, :service_time, :reserve_type, :tailor_id,:created_at, :status, :desc, as: [:get,:list]

  module Type
    SMLT = 1 #上门量体
    SMDZ = 2 #上门定制
    TYD  = 3 #体验店预约
  end

  R_TYPE = {
    "1" => "上门量体",
    "2" => "上门定制",
    "3" => "体验店预约"
  }

  R_STATUS = {
    "0" => "待确认",
    "1" => "已确认",
    "2" => "已完成量体",
    "3" => "生产中",
    "4" => "成功",
    "-1" => "失败"
  }


  def human_type
    R_TYPE[reserve_type.to_s]
  end

  def human_status
    R_STATUS[status.to_s]
  end



end
