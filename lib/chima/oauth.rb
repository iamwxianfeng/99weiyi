#encoding: utf-8

# source https://github.com/simsicon/weibo_2
# https://github.com/046569/qq
# http://wiki.connect.qq.com/get_user_info
# http://open.weibo.com/wiki/2/users/show

require 'timeout'

module Chima

  module Oauth
    class << self

      APP = YAML.load(File.read("#{Rails.root}/config/app.yml"))

      def weibo_user_info(hash)
        WeiboOAuth2::Config.api_key = APP['weibo']['api_key']
        WeiboOAuth2::Config.api_secret = APP['weibo']['api_secret']
        res = []
        begin
          timeout(60) do
            begin
              client = WeiboOAuth2::Client.new
              client.get_token_from_hash({ access_token: hash[:access_token] })
              res = client.users.show_by_uid(hash[:uid]) unless client.users.nil?
            rescue Exception => e
              p res.message
            end
          end
        rescue TimeoutError
          puts "Timed Out"
        end

        return [] if res.empty?

        login = res['name']
        provider_uid = res['id']
        provider_name = 'weibo'
        avatar_url = res['profile_image_url']

        { login: login, provider_uid: provider_uid, provider_name: provider_name, avatar_url: avatar_url}
      end

      def qq_user_info(hash)
        app_id = APP['qq']['api_key']
        res = []
        begin
          timeout(60) do
            user = Qq.new(app_id,hash[:access_token])
            begin
              res = user.get_user_info(APP['qq']['api_url'] + '/user/get_user_info')

            rescue Exception => e
              p e.message
            end
          end
        rescue TimeoutError
          puts "Timed Out"
        end

        return [] if res.empty?

        login = res['nickname']
        provider_name = 'qq'
        avatar_url = res['figureurl_qq_1']
        { login: login, provider_uid: hash[:uid], provider_name: provider_name, vatar_url: avatar_url }
      end
    end

  end
end