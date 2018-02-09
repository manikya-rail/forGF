class AddFieldsToScoreCards < ActiveRecord::Migration[5.0]
  def change
    add_column :score_cards, :rating, :float, default: 0.0
	add_column :score_cards, :slope, :float, default: 0.0
  end
end
