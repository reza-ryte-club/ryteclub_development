class AddAuthorIdToTales < ActiveRecord::Migration
  def change
  	add_column :tales, :author_id, :integer
  end
end
