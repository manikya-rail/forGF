json.extract! course, :id, :name, :type, :bio, :website, :phone_num, :total_par, :slope, :rating, :length, :created_at, :updated_at
json.url course_url(course, format: :json)
