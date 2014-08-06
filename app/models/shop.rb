# encoding:utf-8

class Shop < ActiveRecord::Base
  include Weiyi::Mapper
  include Activerecord::Visible

  attr_visible :id,:address,:name, as: :get

end
