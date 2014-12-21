# encoding: utf-8

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES = %(20x20 30x30 240x240 100x100 120x90 160x120 250x187 320 640 800)
  IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES = %(small large middle thumbnail)
  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    #"uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
     "#{model.class.to_s.underscore}/#{mounted_as}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :scale => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:


  def default_url
    # 搞一个大一点的默认图片取名 blank.png 用 FTP 传入图片空间，用于作为默认图片
    # 由于有自动的缩略图处理，小图也不成问题
    # http://chimaimage.b0.upaiyun.com/defaults/im_tailor.png
    # http://chimaimage.b0.upaiyun.com/defaults/man_default.png
    # http://chimaimage.b0.upaiyun.com/defaults/women_default.png
    url = ''
    if model.class.to_s == 'User'
      url = "chimaimage.b0.upaiyun.com/defaults/man_default.png"  if model.is_male?
      url = "chimaimage.b0.upaiyun.com/defaults/women_default.png" if model.is_female?  
    end

    if model.class.to_s == 'Tailor'
      url = "chimaimage.b0.upaiyun.com/defaults/im_tailor.png"
    end

    p "model.class #{model.class}, #{url}"

    url 
  end

  # 覆盖 url 方法以适应“图片空间”的缩略图命名
  # def url(version_name = "")
  #   @url ||= super({})
  #   version_name = version_name.to_s
  #   return @url if version_name.blank?
  #   if not version_name.in?(IMAGE_UPLOADER_ALLOW_IMAGE_VERSION_NAMES)
  #     # 故意在调用了一个没有定义的“缩略图版本名称”的时候抛出异常，以便开发的时候能及时看到调错了
  #     raise "ImageUploader version_name:#{version_name} not allow."
  #   end
  #   [@url,version_name].join("!") # 我这里在图片空间里面选用 ! 作为“间隔标志符”
  # end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end
  # def filename
  #   if super.present?
  #     model.uploader_secure_token ||= SecureRandom.uuid.gsub("-","")
  #     Rails.logger.debug("(BaseUploader.filename) #{model.uploader_secure_token}")
  #     "#{model.uploader_secure_token}.#{file.extension.downcase}"
  #   end
  # end

  def filename
    if original_filename.present?
      @name ||= Digest::MD5.hexdigest(model.id.to_s + Time.now.to_s)
      "#{@name}.#{file.extension.downcase}"
    end
  end

  # version :small do
  #   process :resize_to_fill => [20, 20]
  # end
  # version :thumb do
  #   process :resize_to_fill => [50, 50]
  # end

  # version :normal do
  #   process :resize_to_fill => [180, 180]
  # end

  # version :original

end
