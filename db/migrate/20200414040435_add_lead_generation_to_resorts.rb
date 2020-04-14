class AddLeadGenerationToResorts < ActiveRecord::Migration[5.0]
  def change
    add_column :resorts, :lead_generation, :boolean
  end
end
