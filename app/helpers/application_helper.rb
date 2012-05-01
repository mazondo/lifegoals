module ApplicationHelper
  def highlight(text)
    b = text.body.dup
    b.gsub!(text.no_tag_reg) {|s| "<span class='label label-inverse'>#{s}</span>"}
    b.gsub!(text.tag_reg) {|s| "<a href='#{tag_path(:tag => s.gsub("\#", ''))}' class='label label-success'>" + s + '</a>'}
    b.gsub!(text.percent_reg) {|s| "<span class='label label-info'>#{s}</span>"}
    b
  end
end
