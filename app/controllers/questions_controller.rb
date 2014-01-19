#encoding: utf-8

class QuestionsController < ApplicationController
	
	before_filter :login_required, :only => [:create]
  
  def index
    @questions = Question.paginate(:page => params[:page]).order('id DESC')
  end

  def new
    @question = Question.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @question }
    end
  end

  def create
    # binding.pry
    @question = Question.new(content: params[:content],url: params[:url], up_size_id: params[:up_size_id], down_size_id: params[:down_size_id],user_id: current_user.id)
    respond_to do |format|
      if @question.save
        format.html { redirect_to questions_path, notice: '您的问题已经成功提交，我们工作人员会及时给你回复，记得查看哦！' }
        format.json { render json: @question, status: :created, location: @question }
      else
        format.html { render action: "new" }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    @question = Question.find(params[:id])
    @answers = @question.answers.paginate(:page => params[:page])
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @question }
    end
  end

end
