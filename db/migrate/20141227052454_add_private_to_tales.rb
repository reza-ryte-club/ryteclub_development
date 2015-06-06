class AddPrivateToTales < ActiveRecord::Migration
  def change
  	    add_column :tales, :private_flag, :integer
  end
end
