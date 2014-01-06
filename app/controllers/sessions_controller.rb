#encoding:utf-8
class SessionsController < ApplicationController

  def new
    redirect_to root_path and return if logged_in?
  end

  def create
    logout_keeping_session!
    user = User.authenticate(params[:email], params[:password])
    if user
      self.current_user = user
      new_cookie_flag = (params[:remember_me] == "1")
      handle_remember_cookie! new_cookie_flag
      redirect_back_or_default('/', :notice => "Logged in successfully")
    else
      note_failed_signin
      @login       = params[:login]
      @remember_me = params[:remember_me]
      render :action => 'new'
    end
  end

  # #<OmniAuth::AuthHash credentials=#<Hashie::Mash expires=true expires_at=1351105200 token="2.00BrF1nBf7yrJC9fece0f4330KpsaL"> extra=#<Hashie::Mash raw_info=#<Hashie::Mash allow_all_act_msg=false allow_all_comment=true avatar_large="http://tp4.sinaimg.cn/1644962363/180/40004500695/1" bi_followers_count=0 city="5" created_at="Fri Sep 04 18:45:06 +0800 2009" description="" domain="" favourites_count=0 follow_me=false followers_count=61 following=false friends_count=6 gender="m" geo_enabled=true id=1644962363 idstr="1644962363" lang="zh-cn" location="北京 朝阳区" name="xianfeng" online_status=0 profile_image_url="http://tp4.sinaimg.cn/1644962363/50/40004500695/1" profile_url="u/1644962363" province="11" remark="" screen_name="xianfeng" status=#<Hashie::Mash attitudes_count=0 comments_count=0 created_at="Tue Oct 09 23:02:39 +0800 2012" favorited=false geo=nil id=3499356047234696 idstr="3499356047234696" in_reply_to_screen_name="" in_reply_to_status_id="" in_reply_to_user_id="" mid="3499356047234696" mlevel=0 reposts_count=0 source="<a href=\"http://weibo.com/\" rel=\"nofollow\">新浪微博</a>" text="@37度体温的微博 我想报名东方时尚驾校, 齐了吗？ 算我一个，行吗？" truncated=false visible=#<Hashie::Mash list_id=0 type=0>> statuses_count=35 url="" verified=false verified_reason="" verified_type=-1 weihao="">> info=#<OmniAuth::AuthHash::InfoHash description="" image="http://tp4.sinaimg.cn/1644962363/50/40004500695/1" location="北京 朝阳区" name="xianfeng" nickname="xianfeng" urls=#<Hashie::Mash Blog="" Weibo="http://weibo.com/u/1644962363">> provider="weibo" uid=1644962363>
  def auth
    auth = request.env["omniauth.auth"]
    # p auth
    uid = auth['uid']
    img = auth['info']['image']
    # p img
    attr = { provider: auth['provider'], visitor_id: auth['uid'], visitor_nick: auth['info']['nickname'], avatar_src: img, login: auth['info']['nickname'] }
    user = User.find_by_visitor_id_and_provider(uid,auth['provider']) || User.new(attr)
    if user.new_record? && user.save(:validate=>false) or user
      session[:user_id] = user.id
      self.current_user = user
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def destroy
    logout_killing_session!
    redirect_back_or_default('/', :notice => "You have been logged out.")
  end

  protected
  def note_failed_signin
    flash.now[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
end
