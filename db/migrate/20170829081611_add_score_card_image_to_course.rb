class AddScoreCardImageToCourse < ActiveRecord::Migration[5.0]
  def change
    add_attachment :courses, :score_card_image
  end
end
