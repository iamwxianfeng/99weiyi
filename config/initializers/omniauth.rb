# open.weibo.com
# http://asciicasts.com/episodes/241-simple-omniauth
# https://github.com/intridea/omniauth
Rails.application.config.middleware.use OmniAuth::Builder do
  # provider :twitter, 'CONSUMER_KEY', 'CONSUMER_SECRET'
  # provider :weibo, '1978116365', '82fa3e1654c905b5b545a16945a0873d'
  # provider :qq, '100317654', 'b1700db0db66d18f0cd507a0068b2f82'
  provider :weibo, '1603641205','6c6830b69f73e5e10902ab8c5a911f70'
  provider :qq, '101008038','dec9253d5cdb2c63868d2bd6e95cdfa5'
end



require 'openssl'

module OpenSSL
  module SSL
    remove_const :VERIFY_PEER
  end
end

OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE