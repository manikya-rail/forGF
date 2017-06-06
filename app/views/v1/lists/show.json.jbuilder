json.data do
  json.list do
    json.id @list.id
    json.name @list.name
    json.user @list.user.name

    json.courses @list.courses do |course|
      json.id course.id
      json.name course.name
    end
  end
end
