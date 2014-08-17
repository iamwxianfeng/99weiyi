# encoding:utf-8
module Chima
  class Token
    def self.secure_digest(*args)
      Digest::SHA1.hexdigest(args.flatten.join('--'))
    end

    ##
    # Example => Entos::Token.make_token
    #            Entos::Token.make_token("wangxianfeng@netposa.com")
    # 结果只有数字+小写字母
    # => e216f21e34b37ee4e9b505e8bbbad52531945c53
    def self.make_token(*args)
      secure_digest(Time.now, (1..10).map{ rand.to_s },args.flatten.join)
    end

    def self.random_code(length=6)
      (0..9).to_a.sample(length).join
    end
  end
end