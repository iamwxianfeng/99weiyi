#encoding: utf-8
class Question < ActiveRecord::Base
	belongs_to :user
	has_many :answers
	validates :content, :length => { :maximum => 100 }, :allow_nil => true
  validates :content, :presence => { message: '内容不能为空' },:length => { :maximum => 200 }

  self.per_page = 10

  def up_size
  	name = nil
  	if self.user && self.up_size_id
  	  if self.user.is_male?
  	  	name = UpSize::M_TYPES.fetch(self.up_size_id.to_s)
  	  end
  	  if self.user.is_female?
  	  	name = UpSize::W_TYPES.fetch(self.up_size_id.to_s)
  	  end 
  	end
  	name
  end

  def down_size
    name = nil
  	if self.user && self.down_size_id
  	  if self.user.is_male?
  	  	name = DownSize::M_TYPES.fetch(self.down_size_id.to_s)
  	  end
  	  if self.user.is_female?
  	  	name = DownSize::W_TYPES.fetch(self.down_size_id.to_s)
  	  end 
  	end
  	name
  end

end
