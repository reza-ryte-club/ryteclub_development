class RemoveBioFromBios < ActiveRecord::Migration
  def change
  	   remove_column :bios, :bio
  end
end


   
