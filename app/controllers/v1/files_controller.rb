#encoding: utf-8

class V1::FilesController < ApplicationController
  layout false

  before_filter :auth_required

  def create
    # file = params[:file]
    filename = Chima::Token.make_token
    file_name = params[:name].to_s
    extense_name = file_name.include?('.') ? file_name.split('.').last : "png"
    tempfile = Tempfile.new([filename,".#{extense_name}"])
    p "name: #{filename}, extense_name: #{extense_name}, tempfile: #{tempfile}"
    tempfile.write(params[:file])
    upload_file = DiskFile.new

    upload_file.file      = tempfile
    upload_file.name      = file_name
    upload_file.mime_type = extense_name
    upload_file.size      = tempfile.size
    upload_file.user_id   = login_user.id
    upload_file.save

    render json: { id: upload_file.id, url: upload_file.file_url }

  end

end