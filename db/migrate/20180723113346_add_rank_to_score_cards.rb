class AddRankToScoreCards < ActiveRecord::Migration[5.0]
  def change
    add_column :score_cards, :rank, :integer
  end
end
