class CreateAds < ActiveRecord::Migration[5.0]
  def change
    create_table :ads do |t|
      t.integer :hole_id
      t.integer :slot_num

      t.timestamps
    end
  end
end
