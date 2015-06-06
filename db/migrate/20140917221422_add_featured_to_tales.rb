class AddFeaturedToTales < ActiveRecord::Migration
  def change
    add_column :tales, :featured, :boolean
  end
end
