CarrierWave.configure do |config|
  config.storage = :upyun
  config.upyun_username = "99weiyiop"
  config.upyun_password = "ca03c28f"
  config.upyun_bucket = "chimaimage"
  config.upyun_bucket_host = "chimaimage.b0.upaiyun.com"
end

# http://chimaimage.b0.upaiyun.com/defaults/im_tailor.png
# http://chimaimage.b0.upaiyun.com/defaults/man_default.png
# http://chimaimage.b0.upaiyun.com/defaults/women_default.png
