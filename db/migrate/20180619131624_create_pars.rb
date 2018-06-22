class CreatePars < ActiveRecord::Migration[5.0]
  def change
    create_table :pars do |t|
      t.integer :score_card_id
      t.integer :hole_id
      t.integer :par

      t.timestamps
    end
  end
end
