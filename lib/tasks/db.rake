#encoding: utf-8
namespace :db do
  desc 'create admin'
  task :create_admin => :environment do
    last_id = User.last.id + 1
    login = "admin_#{last_id}"
    password = ('a'..'z').to_a.sample(6).join
    user = User.create(email: "#{login}@99weiyi.com", login: login, role_id: 2, password: password, password_confirmation: password)
    p "admin account created success!"
    p "account: #{user.email}, password: #{user.password}"
    p "Please change password quickly!"
  end
end

