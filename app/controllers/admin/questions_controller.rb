# encoding:utf-8
class Admin::QuestionsController < ApplicationController
  layout 'admin'

  def index
    @questions = Question.all
  end
end