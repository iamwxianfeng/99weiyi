# encoding:utf-8

module Chima
  class File
    def self.digest(file)
      file.rewind
      Digest::SHA1.hexdigest(file.read)
    end
  end
end