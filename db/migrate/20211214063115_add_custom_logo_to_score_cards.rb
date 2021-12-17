class AddCustomLogoToScoreCards < ActiveRecord::Migration[5.0]
  def change
    add_attachment :score_cards, :custom_logo
  end
end
