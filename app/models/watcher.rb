#encoding:utf-8
class Watcher < AB
  belongs_to :watchable, :polymorphic => true
  belongs_to :user
end