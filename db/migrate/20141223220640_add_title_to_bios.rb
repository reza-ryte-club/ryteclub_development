class AddTitleToBios < ActiveRecord::Migration
  def change
  	    add_column :bios, :title, :text
  end
end



