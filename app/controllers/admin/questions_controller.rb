# encoding:utf-8
class Admin::QuestionsController < ApplicationController
  layout 'admin'
  
	before_filter :logged_as_manager
  
  def index
    @questions = Question.paginate(:page => params[:page]).order('id DESC')
  end

  def show
  	@question = Question.find_by_id(params[:id])
  end
  
end