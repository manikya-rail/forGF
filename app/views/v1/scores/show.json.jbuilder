json.data do
  json.score do
    json.score @score.score

    json.user do
      json.id @score.user.id
      json.name @score.user.name
    end

    json.hole do
      json.id @score.hole.id
    end
  end
end
