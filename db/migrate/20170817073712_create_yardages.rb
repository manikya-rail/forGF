class CreateYardages < ActiveRecord::Migration[5.0]
  def change
    create_table :yardages do |t|
      t.references :score_card, foreign_key: true
      t.references :hole, foreign_key: true
      t.integer :yards

      t.timestamps
    end
  end
end
