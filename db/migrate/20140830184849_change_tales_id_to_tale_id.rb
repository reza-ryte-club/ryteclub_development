class ChangeTalesIdToTaleId < ActiveRecord::Migration
  def change
  	rename_column :plots, :tales_id, :tale_id
  end
end
