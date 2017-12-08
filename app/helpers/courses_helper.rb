module CoursesHelper
  def color_selector(color)
    if color.present?
      if color.chars.first != '#'
      	color.prepend('#')
      	return color
      elsif (color.chars.first == '#' && (color.length == 7 || color.length == 4 ))
        return color
      end
    else
      return '#15a575'
    end
  end
end
