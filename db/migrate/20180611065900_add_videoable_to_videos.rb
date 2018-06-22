class AddVideoableToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :videoable_type, :string
    add_column :videos, :videoable_id, :integer
  end
end
