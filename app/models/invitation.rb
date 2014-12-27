# encoding:utf-8

class Invitation < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  belongs_to :user

  attr_visible :id, :status, as: [:get,:list]
end
