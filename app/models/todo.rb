class Todo < ActiveRecord::Base
  attr_accessible :complete, :goal_id, :title
  belongs_to :goal
  
  validates_presence_of :title
  
  after_save :create_comment
  
  private
  
  def create_comment
    self.goal.comments.new(:body => "Checklist Item created: #{self.title}").save!
  end
end
