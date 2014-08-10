# encoding: utf-8

module V1Helper

    def login_user=(user)
      @login_user = user
    end

    def auth_user(access_token)
      return nil unless access_token
      User.find_by_access_token(access_token)
    end

    def login_user
      @login_user ||= auth_user(current_token)
    end

    def current_token
      # get access_token from cookies get post header
      @access_token ||= params[:access_token]
      @access_token ||= request.cookies["access_token"]

      return nil unless @access_token
      @access_token
    end

    def signed_in?
      !login_user.nil?
    end

    def auth_required
      unless signed_in?
        return render status: 401,  :json => { error: '认证失败'}
      end
    end

end