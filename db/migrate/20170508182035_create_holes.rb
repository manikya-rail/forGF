class CreateHoles < ActiveRecord::Migration[5.0]
  def change
    create_table :holes do |t|
      t.string :par
      t.string :yards
      t.string :mhcp
      t.string :whcp
      t.references :course, index: true
      t.timestamps
    end
  end
end
