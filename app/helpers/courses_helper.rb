module CoursesHelper
  def color_selector(color)
    if color.chars.first != '#' 
    	color.prepend('#')
    	return color
    elsif (color.chars.first == '#' && (color.length == 7 || color.length == 4 ))
      return color
    end
  end
end
