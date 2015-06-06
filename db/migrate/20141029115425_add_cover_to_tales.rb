class AddCoverToTales < ActiveRecord::Migration
  def change
    add_column :tales, :cover, :string
  end
end
