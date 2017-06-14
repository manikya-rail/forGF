class CreateScores < ActiveRecord::Migration[5.0]
  def change
    create_table :scores do |t|
      t.integer :score
      t.references :user, index: true
      t.references :hole, index: true
      t.timestamps
    end
  end
end
