#encoding: utf-8
class Question < ActiveRecord::Base
	belongs_to :user
	validates :content, :length => { :maximum => 100 }, :allow_nil => true
  validates :content, :presence => { message: '内容不能为空' },:length => { :maximum => 200 }
end
