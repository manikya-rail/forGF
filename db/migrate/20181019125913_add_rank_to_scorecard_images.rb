class AddRankToScorecardImages < ActiveRecord::Migration[5.0]
  def change
    add_column :scorecard_images, :rank, :integer
  end
end
