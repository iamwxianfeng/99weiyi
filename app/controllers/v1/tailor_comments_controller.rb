#encoding: utf-8

class V1::TailorCommentsController < ApplicationController
  layout false

  before_filter :auth_required

  def create
      # todo 预约成功才可以评论
      tailor = Tailor.find_by_id(params[:tailor_id])
      if tailor
        tailor_comment = tailor.tailor_comments.create(content: params[:content], rating: params[:rating].to_i, commenter_id: login_user.id)
        upload_pic(tailor_comment, params[:pictures] || [])
        render json: tailor_comment.to_hash(:get)
      else
        render status: 422, json: {message: '评论失败' }
      end
  end

  def index
    tailor = Tailor.find_by_id(params[:tailor_id])
    tailor_comments = []
    tailor.tailor_comments.each do |tc|
      tailor_comments <<  tc.to_hash(:list).merge!({commenter_name: tc.commenter_name, pictures: tc.comment_images})
    end
    render json: tailor_comments
  end

  private
    def upload_pic tailor_comment, pictures
      pictures.each do |pic|
        filename = Chima::Token.make_token
        tempfile = Tempfile.new([filename,".png"])
        tempfile.write(pic)
        tailor_comment.tailor_comment_images.create(image: tempfile)
      end
    end


end