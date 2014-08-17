#encoding: utf-8

class UserMailer < ActionMailer::Base

  @queue = :user_mailer
  # default :from => "99weiyi@163.com"
  HOST = Rails.env.development? ? 'localhost' : 'http://99weiyi.com'
  SITE = Rails.env.development? ? HOST+":3000" : HOST
  MAIL_FROM = Rails.env.development? ? "noreply@entfield.com" : "noreply@entfield.com"
  default :from => "zufanglushang@163.com"

  def self.perform(user_id,branch,options={})
    case branch
    when /activation/
      user = User.find(user_id)
      activation(user).deliver
    end
  end

  # def signup_notification(user)
  #   setup_email(user)
  #   @subject  += 'Please activate your new account'
  #   @url  = "http://#{SITE}/activate/#{user.activation_code}"
  # end

  def activation(user)
    @subject = '［99维衣］请激活您的邮件账号'
    @url = "http://#{SITE}/activate/#{user.activation_code}"
    @to_user = user
    mail(:to => user.email,:subject => @subject)
  end

  protected

  def setup_email(user)
    # @recipients  = "#{user.email}"
    @from        = MAIL_FROM
    @subject     = @subject
    # @sent_on     = Time.now
    @user = user
  end

end
