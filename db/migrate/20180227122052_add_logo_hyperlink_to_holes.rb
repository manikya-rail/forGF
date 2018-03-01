class AddLogoHyperlinkToHoles < ActiveRecord::Migration[5.0]
  def change
    add_column :holes, :logo_hyperlink, :string
  end
end
