class DiskFile < AB
  belongs_to :user
  belongs_to :item, :polymorphic => true

  PATH = "#{Rails.root}/public/files"

  def location_dirname
    digest.first(2)
  end

  def location_filename
    digest.from(2)
  end

  def dir_location
    d = "#{PATH}/#{location_dirname}"
    FileUtils.mkdir_p(d) unless Dir.exists?(d)
    d
  end

  def location
    "#{dir_location}/#{location_filename}"
  end

  def path
    "/files/#{location_dirname}/#{location_filename}"
  end

end