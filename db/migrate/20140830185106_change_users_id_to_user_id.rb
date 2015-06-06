class ChangeUsersIdToUserId < ActiveRecord::Migration
  def change
  	rename_column :plots, :users_id, :user_id

  end
end
