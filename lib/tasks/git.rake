# encoding:utf-8
namespace :git do

  desc "tag and release entos, then push to git server"
  task :release  => :environment do
    puts "\nEntos Release 开始鸟...\n"

    puts "\n创建release-#{Chima::VERSION}分支\n"
    system "git checkout -b release-#{Entos::VERSION} master"
    system "git commit -a -m 'Bumped version number to #{Entos::VERSION}'"
    system "git push"

    puts "\n建立tag #{Entos::VERSION}\n"
    system "git tag -a #{Entos::VERSION} -m 'tag #{Entos::VERSION}'"
    system "git push origin --tags"

    puts "\n切换回master branch\n"
    system "git checkout master"
    puts "\n...END!!!\n"
  end

end