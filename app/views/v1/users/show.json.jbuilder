json.user do
  json.id @user.id
  json.first_name @user.first_name
  json.last_name @user.last_name
  json.picture @user.picture.url
  json.location @user.location
  json.gender @user.gender
  json.home_courses @user.home_courses
  json.handicap_value @user.handicap_value
end
