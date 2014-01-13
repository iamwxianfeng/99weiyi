# encoding:utf-8
class Admin::QuestionsController < ApplicationController
  layout 'admin'
	# before_filter :login_required
  
  def index
    @questions = Question.all
  end
  
end