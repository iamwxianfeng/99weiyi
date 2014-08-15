# encoding:utf-8

class Passport < ActiveRecord::Base

  belongs_to :user
end
