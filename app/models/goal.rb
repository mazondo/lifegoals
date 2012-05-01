class Goal < ActiveRecord::Base
  attr_accessible :progress, :title
  default_scope :order => "created_at DESC"
  acts_as_taggable_on :tags
  
  has_many :comments, :dependent => :destroy, :order => "created_at DESC"
  has_many :todos, :dependent => :destroy, :order => "complete ASC"
  
  validates_presence_of :title
end
