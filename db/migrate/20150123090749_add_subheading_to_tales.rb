class AddSubheadingToTales < ActiveRecord::Migration
  def change
  	 	    add_column :tales, :subheading, :text
  end
end

