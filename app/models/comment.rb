class Comment < ActiveRecord::Base
  attr_accessible :body, :goal_id
  
  acts_as_taggable_on :tags
  
  validates_presence_of :body, :goal_id
  
  belongs_to :goal
  
  before_save :parse_comment_for_goal_changes
  before_save :parse_comment_for_comment_tags
  
  def tag_reg
    /#\w+/
  end
  
  def comment_tag_reg
    /\*\w+/
  end
  
  def no_tag_reg
    /(\s|\A)-(\w+)/
  end
  
  def percent_reg
    /[0-9]{0,3}\s*%/
  end
  
  private
  
  def parse_comment_for_goal_changes
    if self.valid?
      self.goal.tag_list = parse_for_tags
      self.goal.progress = parse_for_completion unless parse_for_completion.blank?
      self.goal.save!
    end
  end
  
  def parse_comment_for_comment_tags
    self.tag_list = parse_for_comment_tags
  end
  
  def parse_for_comment_tags
    reg = comment_tag_reg
		comment_tags = body.scan(reg)
		comment_tags.each do |a|
			a = a.gsub! "*", ""
		end
		return comment_tags.join(", ")
  end
  
  def parse_for_tags
    reg = tag_reg
    tags = body.scan(reg)
    all_tags = self.goal.tag_list.split(", ") || nil
    unless tags.blank?
		  tags.each do |p|
  			p = p.gsub! "\#", ""
  		end
  		all_tags = all_tags.flatten + tags.flatten
	  end
	  reg = no_tag_reg
	  tags = body.scan(reg)
	  unless tags.blank?
	    tags.flatten.each do |p|
	      p = p.gsub! "-", ""
      end
      all_tags = all_tags.flatten - tags.flatten
    end
	  return all_tags.join(", ")
  end
  
  def parse_for_completion
    reg = percent_reg
		percent = body.scan(reg)
		unless percent.blank?
		  p = percent.first
		  p = p.gsub! '%', ''
  		return p.to_i
	  end
  end
end
