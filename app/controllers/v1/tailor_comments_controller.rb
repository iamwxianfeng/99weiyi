#encoding: utf-8

class V1::TailorCommentsController < ApplicationController
  layout false

  before_filter :auth_required

  def create
      # todo 预约成功才可以评论
      rating = [1,2,3,4,5].include?(params[:rating].to_i) ? params[:rating].to_i : 1

      tailor = Tailor.find_by_id(params[:tailor_id])
      if tailor
        tailor_comment = tailor.tailor_comments.create(content: params[:content], rating: rating, commenter_id: login_user.id)
        upload_pic(tailor_comment, params[:picture_ids] || [])
        render json: tailor_comment.to_hash(:get)
      else
        render status: 422, json: {message: '评论失败' }
      end
  end

  def index
    tailor = Tailor.find_by_id(params[:tailor_id])
    tailor_comments = []
    # @comments = @business.comments.paginate(:page => params[:page], :per_page => 7)
    tailor.tailor_comments.paginate(:page => params[:page]).each do |tc|
      tailor_comments <<  tc.to_hash(:list).merge!({commenter_name: tc.commenter_name, pictures: tc.comment_images})
    end
    render json: tailor_comments
  end

  private
    def upload_pic tailor_comment, picture_ids
      picture_ids.each do |id|
        tailor_comment.tailor_comment_images.create(image_id: id)
      end
    end


end