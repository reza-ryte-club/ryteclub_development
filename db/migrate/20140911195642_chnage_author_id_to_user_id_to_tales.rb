class ChnageAuthorIdToUserIdToTales < ActiveRecord::Migration
  
  def change
  	rename_column :tales, :author_id, :user_id
  end
  
end
