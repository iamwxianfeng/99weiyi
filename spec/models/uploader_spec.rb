require 'spec_helper'

describe 'Uploader' do
  # pending "add some examples to (or delete) #{__FILE__}"
  it 'upload to upyun' do
    p "upload to upyun ..."
    file_path = '/Users/jidongdong/Downloads/img/pic/default.jpg'
    u = User.new(avatar: File.open(file_path))
    u.save(validate: false)
    p u.id
    p u.avatar.url
  end

end
