class Goal < ActiveRecord::Base
  attr_accessible :progress, :title
  default_scope :order => "created_at DESC"
  acts_as_taggable_on :tags
  acts_as_tagger
  
  has_many :comments, :dependent => :destroy, :order => "created_at DESC"
  has_many :todos, :dependent => :destroy, :order => "complete ASC"
  belongs_to :user
  
  validates_presence_of :title
end
