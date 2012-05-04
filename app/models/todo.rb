class Todo < ActiveRecord::Base
  attr_accessible :complete, :goal_id, :title
  belongs_to :goal, :touch => true
  
  validates_presence_of :title
  
  after_create :create_comment
  after_update :update_comment
  
  scope :next_action , where("complete = ? OR complete IS NULL", false)
  
  private
  
  def create_comment
    self.goal.comments.new(:body => "Checklist Item created: #{self.title}").save!
  end
  
  def update_comment
    if self.complete == true
      self.goal.comments.new(:body => "Item Completed: #{self.title}").save!
    end
  end
end
