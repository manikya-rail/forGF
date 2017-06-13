json.data do
  json.review do
    json.id @review.id
    json.overall_rating @review.overall_rating
    json.value_rating @review.overall_rating
    json.course_upkeep_rating @review.course_upkeep_rating
    json.customer_service_rating @review.customer_service_rating
    json.clubhouse_vibe_rating @review.clubhouse_vibe_rating
    json.text @review.text

    json.user do
      json.id @review.user.id
      json.name @review.user.name
    end

    json.course do
      json.id @review.course.id
      json.name @review.course.name
    end
  end
end
