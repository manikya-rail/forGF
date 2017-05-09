class CreateScoreCards < ActiveRecord::Migration[5.0]
  def change
    create_table :score_cards do |t|
      t.string :tee_name
      t.string :color
      t.references :course, index: true
      t.timestamps
    end
  end
end
