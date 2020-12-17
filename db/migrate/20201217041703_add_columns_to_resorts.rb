class AddColumnsToResorts < ActiveRecord::Migration[5.0]
  def change
    add_column :resorts, :fore_btn_background, :string
    add_column :resorts, :fore_btn_text, :string
    add_column :resorts, :fore_line_color, :string
  end
end
