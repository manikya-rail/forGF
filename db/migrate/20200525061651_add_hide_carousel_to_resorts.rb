class AddHideCarouselToResorts < ActiveRecord::Migration[5.0]
  def change
    add_column :resorts, :hide_carousel, :boolean
  end
end