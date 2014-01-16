#encoding: utf-8

class V1::QuestionsController < ApplicationController

  layout false
  before_filter :request_user

  def create
    attr = {user_id: @user.id,up_size_id: params[:up_size_id],down_size_id: params[:down_size_id],url: params[:url],content: params[:content]}
    question = Question.new(attr)
    if question.save
		  render status: 201, json: {message: "ok"}
    else
		  render status: 410, json: {error: question.errors}
    end
    
  end

  private
    def request_user
    	@user = User.find_by_access_token(params[:access_token])
      if  params[:access_token].nil? || @user.nil?
        return render status: 410, json: {message: "请登录!"}
      end
    end
end