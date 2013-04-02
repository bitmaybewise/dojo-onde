module UsersHelper
  def errors_for(attr)
    if attr.any?
      messages = ""
      attr.each {|e| messages << "#{e}<br/>"}
      "<p class='alert alert-error'>#{messages}</p>".html_safe
    end
  end
end
