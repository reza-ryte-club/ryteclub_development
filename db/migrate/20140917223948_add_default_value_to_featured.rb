class AddDefaultValueToFeatured < ActiveRecord::Migration
  def change
  	
    change_column :tales, :featured, :boolean, default: false

  end
end
