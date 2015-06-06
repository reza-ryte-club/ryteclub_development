class DeleteCoverFromTales < ActiveRecord::Migration
  def change
   remove_column :tales, :cover
  end
end
