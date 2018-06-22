class CreateHcps < ActiveRecord::Migration[5.0]
  def change
    create_table :hcps do |t|
      t.integer :score_card_id
      t.integer :hole_id
      t.integer :hcp

      t.timestamps
    end
  end
end
