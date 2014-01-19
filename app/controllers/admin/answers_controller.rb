# encoding:utf-8
class Admin::AnswersController < ApplicationController
  layout 'admin'
	before_filter :logged_as_manager
  
  def create
    @question = Question.find_by_id(params[:question_id])
    answer = current_user if current_user
    binding.pry
    attr = {:content => params[:answer][:content],:user_id => answer.id }
    if @question && @question.answers.create(attr)
      redirect_to [:admin,@question]
    else
      render :json=>{ retCode: 0 }
    end
  end
  
end