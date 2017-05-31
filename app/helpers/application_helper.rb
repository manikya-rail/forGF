module ApplicationHelper
  def embed_iframe(content)
    "<iframe width='560' height='315' src='#{content}' frameborder='0' allowfullscreen></iframe>"
  end
end
