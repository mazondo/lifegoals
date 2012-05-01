module ApplicationHelper
  def highlight(text)
    b = text.body.dup
    b.gsub!(text.no_tag_reg) {|s| "<span class='label label-inverse'>#{s}</span>"}
    b.gsub!(text.tag_reg) {|s| "<a href='#{tag_path(:tag => s.gsub("\#", ''))}' class='label label-success'>" + s + '</a>'}
    b.gsub!(text.percent_reg) {|s| "<span class='label label-info'>#{s}</span>"}
    b.gsub!(text.comment_tag_reg) {|s| "<span class='label label-danger'>#{s}</span>"}
    b
  end
  
  #let's make bootstrap friendly error messages@
  def notice_type(type)
    case type
      when :alert
        "alert-warning"
      when :error
        "alert-error"
      when :notice
        "alert-info"
      when :success
        "alert-success"
      else
        "alert-#{type.to_s}"
    end
  end
end
