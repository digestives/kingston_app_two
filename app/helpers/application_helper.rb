module ApplicationHelper


  def title
    base_title = "Kingston Leisure"
    if @title.nil?
      return base_title
    else
      return "#{base_title} | #{@title}"
    end
  end

  def logo
		image_tag("logo.png", :alt => "Kingston Leisure")
	end

end

