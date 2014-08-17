require "resque/tasks"

#rake resque:work QUEUE='*'
task "resque:setup" => :environment