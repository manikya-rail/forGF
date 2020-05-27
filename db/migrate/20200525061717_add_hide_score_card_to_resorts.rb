class AddHideScoreCardToResorts < ActiveRecord::Migration[5.0]
  def change
    add_column :resorts, :hide_score_card, :boolean
  end
end