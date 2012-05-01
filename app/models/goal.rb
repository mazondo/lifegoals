class Goal < ActiveRecord::Base
  attr_accessible :progress, :title
  acts_as_taggable_on :tags
  
  has_many :comments, :dependent => :destroy, :order => "created_at DESC"
end
