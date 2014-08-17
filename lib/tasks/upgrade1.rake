#encoding: utf-8
namespace :db do
  desc 'invite_code insert'
  task 'user_invite_code' => :environment do
    User.find_each do |u|
      unless u.invite_code.present?
        u.invite_code = Chima::Token.random_code
        u.save(validate: false)
        p u.invite_code
      end
    end

    p "succees"
  end
end

